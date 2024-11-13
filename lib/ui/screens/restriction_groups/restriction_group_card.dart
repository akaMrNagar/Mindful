import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/providers/invincible_mode_provider.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/time_text_short.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_group_bottom_sheet.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class RestrictionGroupCard extends ConsumerWidget {
  const RestrictionGroupCard({
    super.key,
    required this.group,
    this.position,
  });

  final RestrictionGroup group;
  final ItemPosition? position;

  void _updateGroup(
    BuildContext context,
    WidgetRef ref,
    int remainingTimeSec,
  ) async {
    final isInvincibleModeRestricted = ref.read(invincibleModeProvider
        .select((v) => v.isInvincibleModeOn && v.includeGroupsTimer));

    if (isInvincibleModeRestricted && remainingTimeSec <= 0) {
      context.showSnackAlert(
        context.locale.invincible_mode_snack_alert,
      );
      return;
    }

    final updatedGroup = await showCreateUpdateRestrictionGroupSheet(
      context: context,
      group: group,
    );

    if (updatedGroup != null) {
      /// Update group
      ref
          .read(restrictionGroupsProvider.notifier)
          .updateGroup(group: updatedGroup);

      /// Update associated group ids for apps
      ref.read(appsRestrictionsProvider.notifier).updateAssociatedGroupId(
            appPackages: updatedGroup.distractingApps,
            groupId: updatedGroup.id,
            removedAppPackages: group.distractingApps
                .where((e) => !updatedGroup.distractingApps.contains(e))
                .toList(),
          );
    }
  }

  void _removeGroup(
    BuildContext context,
    WidgetRef ref,
    int remainingTimeSec,
  ) async {
    final isInvincibleModeRestricted = ref.read(invincibleModeProvider
        .select((v) => v.isInvincibleModeOn && v.includeGroupsTimer));

    if (isInvincibleModeRestricted && remainingTimeSec <= 0) {
      context.showSnackAlert(
        context.locale.invincible_mode_snack_alert,
      );
      return;
    }

    final confirm = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.removeRestrictionGroupTag(group.id),
      title: context.locale.remove_restriction_group_dialog_title,
      info:
          context.locale.remove_restriction_group_dialog_info(group.groupName),
      icon: FluentIcons.delete_20_filled,
      positiveLabel: context.locale.dialog_button_remove,
    );

    if (!confirm) return;

    /// Update associated group ids for apps
    ref.read(appsRestrictionsProvider.notifier).updateAssociatedGroupId(
      appPackages: [],
      groupId: null,
      removedAppPackages: group.distractingApps,
    );

    /// remove group
    ref.read(restrictionGroupsProvider.notifier).removeGroup(group: group);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appsMap = ref.watch(appsProvider);
    final apps = group.distractingApps.map((e) => appsMap.value?[e]).toList();
    final totalTimeSec = apps.fold(
        0, (time, e) => time + (e?.screenTimeThisWeek[todayOfWeek] ?? 0));

    final remainingTimeSec = max(0, (group.timerSec - totalTimeSec));
    double progress = totalTimeSec <= 0 || remainingTimeSec <= 0
        ? 0
        : max(0, remainingTimeSec / group.timerSec);
    final isPurged = totalTimeSec >= group.timerSec;

    return RoundedContainer(
      borderRadius: getBorderRadiusFromPosition(position ?? ItemPosition.none),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: Theme.of(context).colorScheme.surfaceContainer,
      onPressed: () => _updateGroup(context, ref, remainingTimeSec),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /// Remaining time indicator
              Container(
                height: 36,
                width: 36,
                padding: const EdgeInsets.all(4),
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: 1,
                      strokeCap: StrokeCap.round,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    CircularProgressIndicator(
                      value: progress,
                      strokeCap: StrokeCap.round,
                    ),
                  ],
                ),
              ),

              12.hBox,

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Group title
                  StyledText(
                    group.groupName,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),

                  /// Active/Paused label
                  StyledText(
                    isPurged
                        ? context.locale.timer_status_paused
                        : context.locale.timer_status_active,
                    fontWeight: FontWeight.w600,
                    color: isPurged
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),

              const Spacer(),
              TimeTextShort(
                timeDuration: group.timerSec.seconds,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                secondaryFontWeight: FontWeight.w600,
              ),
            ],
          ),

          12.vBox,

          /// Used time
          StyledText(
            context.locale.restriction_group_time_used(totalTimeSec.seconds
                .toTimeFull(context, replaceCommaWithAnd: true)),
            color: Theme.of(context).hintColor,
            fontSize: 14,
          ),

          /// Remaining time
          StyledText(
            context.locale.restriction_group_time_left(remainingTimeSec.seconds
                .toTimeFull(context, replaceCommaWithAnd: true)),
            color: Theme.of(context).hintColor,
            fontSize: 14,
          ),

          // const Divider(),
          12.vBox,

          /// Apps
          SizedBox(
            height: 64,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];

                return Padding(
                  padding: const EdgeInsets.all(3),
                  child: app != null ? ApplicationIcon(app: app) : 0.vBox,
                );
              },
            ),
          ),

          /// Remove button
          DefaultHero(
            tag: HeroTags.removeRestrictionGroupTag(group.id),
            child: FilledButton.tonal(
              onPressed: () => _removeGroup(context, ref, remainingTimeSec),
              child: Text(context.locale.dialog_button_remove),
            ).rightCentered,
          ),
        ],
      ),
    );
  }
}
