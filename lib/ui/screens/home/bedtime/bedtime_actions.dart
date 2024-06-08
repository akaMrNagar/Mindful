import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:mindful/ui/screens/home/bedtime/distracting_apps_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BedtimeActions extends ConsumerStatefulWidget {
  const BedtimeActions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BedtimeActionsState();
}

class _BedtimeActionsState extends ConsumerState<BedtimeActions> {
  bool isDistractingAppsListExpanded = false;

  void _togglePauseApps(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleScreenLockdown();

  void _togglePauseInternet(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleInternetLockdown();

  void _toggleDND(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleDND();

  @override
  Widget build(BuildContext context) {
    final isScheduleActive =
        ref.watch(bedtimeProvider.select((value) => value.scheduleStatus));

    final pauseApps =
        ref.watch(bedtimeProvider.select((value) => value.startScreenLockdown));

    final pauseInternet = ref
        .watch(bedtimeProvider.select((value) => value.startInternetLockdown));

    final startDnd =
        ref.watch(bedtimeProvider.select((value) => value.startDnd));

    return MultiSliver(
      children: [
        SliverList.list(
          children: [
            /// Pause Apps
            SwitchableListTile(
              value: pauseApps,
              enabled: !isScheduleActive,
              onPressed: () => _togglePauseApps(ref),
              titleText: "Pause apps",
              subTitleText: "Pause apps with timers On",
            ),

            /// Pause Internet
            SwitchableListTile(
              value: pauseInternet,
              enabled: !isScheduleActive,
              onPressed: () => _togglePauseInternet(ref),
              titleText: "Block internet",
              subTitleText: "Block internet access for selected apps",
            ),

            /// DND Mode
            SwitchableListTile(
              value: startDnd,
              enabled: !isScheduleActive,
              onPressed: () => _toggleDND(ref),
              titleText: "Start do not disturb",
              subTitleText:
                  "Only calls from starred contacts, \nrepeat callers and alarms can reach you.",
            ),

            /// Manage Dnd settings
            RoundedContainer(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              onPressed: () {},
              child: ListTileSkeleton(
                leading: Icon(
                  FluentIcons.alert_20_regular,
                  color:
                      isScheduleActive ? Theme.of(context).disabledColor : null,
                ),
                title: StatefulText(
                  "Do not disturb settings",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  isActive: !isScheduleActive,
                ),
                subtitle: const StatefulText(
                  "Manage which app are distracting you from your routine.",
                  fontSize: 14,
                  isActive: false,
                ),
                trailing: Icon(
                  FluentIcons.chevron_right_20_filled,
                  color:
                      isScheduleActive ? Theme.of(context).disabledColor : null,
                ),
              ),
            ),

            /// Manage distracting apps
            RoundedContainer(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              onPressed: () => setState(
                () => isDistractingAppsListExpanded =
                    !isDistractingAppsListExpanded,
              ),
              child: ListTileSkeleton(
                leading: Icon(
                  FluentIcons.weather_moon_20_regular,
                  color:
                      isScheduleActive ? Theme.of(context).disabledColor : null,
                ),
                title: StatefulText(
                  "Distracting apps",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  isActive: !isScheduleActive,
                ),
                subtitle: const StatefulText(
                  "Manage which app are distracting you from your routine.",
                  fontSize: 14,
                  isActive: false,
                ),
                trailing: AnimatedRotation(
                  duration: 250.ms,
                  turns: isDistractingAppsListExpanded ? 0.5 : 0,
                  child: Icon(
                    FluentIcons.chevron_down_20_filled,
                    color: isScheduleActive
                        ? Theme.of(context).disabledColor
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),

        /// Distracting apps list
        if (isDistractingAppsListExpanded) const DistractingAppsList(),

        72.vSliverBox(),
      ],
    );
  }
}
