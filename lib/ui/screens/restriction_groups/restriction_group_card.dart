import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/time_text_short.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_group_bottom_sheet.dart';

class RestrictionGroupCard extends ConsumerWidget {
  const RestrictionGroupCard({
    super.key,
    required this.group,
  });

  final RestrictionGroup group;

  void _updateGroup(BuildContext context, WidgetRef ref) async {
    final updatedGroup = await showEditInsertRestrictionGroupSheet(
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
          oldAppPackages: group.distractingApps
              .where((e) => !updatedGroup.distractingApps.contains(e))
              .toList());
    }
  }

  void _removeGroup(BuildContext context, WidgetRef ref) async {
    // final confirm = await
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
      circularRadius: 24,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: Theme.of(context).colorScheme.surfaceContainer,
      onPressed: () => _updateGroup(context, ref),
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
                    isPurged ? "PAUSED" : "ACTIVE",
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
            "Used: ${totalTimeSec.seconds.toTimeFull(context)}",
            color: Theme.of(context).hintColor,
            fontSize: 14,
          ),

          /// Remaining time
          StyledText(
            "Remaining: ${remainingTimeSec.seconds.toTimeFull(context)}",
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
          FilledButton.tonal(
            onPressed: () => _removeGroup(context, ref),
            child: const Text("Remove"),
          ).rightCentered,
        ],
      ),
    );
  }
}
