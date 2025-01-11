import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/invincible_mode_provider.dart';
import 'package:mindful/providers/new/apps_info_provider.dart';
import 'package:mindful/providers/new/todays_apps_usage_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/time_text_short.dart';
import 'package:mindful/ui/screens/restriction_groups/create_update_group_screen.dart';

class RestrictionGroupCard extends ConsumerWidget {
  const RestrictionGroupCard({
    super.key,
    required this.group,
    this.position,
  });

  final RestrictionGroup group;
  final ItemPosition? position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupedApps = ref
            .watch(appsInfoProvider.select((v) => v.value?.values
                .where((e) => group.distractingApps.contains(e.packageName))))
            ?.toList() ??
        [];

    final timeSpent = ref
            .watch(todaysAppsUsageProvider.select(
              (v) => v.value?.entries.where((e) => groupedApps.contains(e.key)),
            ))
            ?.fold(0, (time, entry) => time + entry.value.screenTime) ??
        0;

    final timeLeft = max(0, (group.timerSec - timeSpent));

    double progress =
        timeSpent <= 0 || timeLeft <= 0 ? 0 : max(0, timeLeft / group.timerSec);

    return RoundedContainer(
      borderRadius: getBorderRadiusFromPosition(position ?? ItemPosition.none),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: Theme.of(context).colorScheme.surfaceContainer,
      onPressed: () => _goToEditScreen(context, ref, timeLeft),
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
                      value: group.timerSec > 0 ? progress : 1,
                      strokeCap: StrokeCap.round,
                    ),
                  ],
                ),
              ),

              12.hBox,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Group title
                    StyledText(
                      group.groupName,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    /// Active period
                    StyledText(
                      group.periodDurationInMins > 0
                          ? context.locale.app_active_period_tile_subtitle(
                              group.activePeriodStart.format(context),
                              group.activePeriodEnd.format(context),
                            )
                          : context.locale.app_limit_status_not_set,
                      color: Theme.of(context).hintColor,
                    ),
                  ],
                ),
              ),

              12.hBox,

              if (group.timerSec > 0)
                TimeTextShort(
                  timeDuration: group.timerSec.seconds,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  secondaryFontWeight: FontWeight.w600,
                ),
            ],
          ),
          12.vBox,

          /// Apps
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              height: 40,
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: groupedApps.length,
                itemBuilder: (context, index) {
                  final app = groupedApps[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: ApplicationIcon(
                      appInfo: app,
                      size: 14,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToEditScreen(BuildContext context, WidgetRef ref, int timeLeft) {
    final invincibleMode = ref.read(invincibleModeProvider);

    final canModifyTimer = !(invincibleMode.isInvincibleModeOn &&
        invincibleMode.includeGroupsTimer &&
        group.timerSec > 0 &&
        timeLeft <= 0);

    final canModifyActivePeriod = !(invincibleMode.isInvincibleModeOn &&
        invincibleMode.includeGroupsActivePeriod &&
        group.periodDurationInMins > 0 &&
        !DateTime.now().isBetweenTod(
          group.activePeriodEnd,
          group.activePeriodStart,
        ));

    /// Go to screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateUpdateRestrictionGroupScreen(
          group: group,
          canUpdateTimer: canModifyTimer,
          canUpdateActivePeriod: canModifyActivePeriod,
        ),
      ),
    );
  }
}
