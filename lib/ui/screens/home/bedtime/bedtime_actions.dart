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
      ref.read(bedtimeProvider.notifier).toggleShouldPauseApps();

  void _togglePauseInternet(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleShouldBlockInternet();

  void _toggleDND(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleShouldStartDnd();

  @override
  Widget build(BuildContext context) {
    final isScheduleOn =
        ref.watch(bedtimeProvider.select((value) => value.isScheduleOn));

    final shouldPauseApps =
        ref.watch(bedtimeProvider.select((value) => value.shouldPauseApps));

    final shouldBlockInternet =
        ref.watch(bedtimeProvider.select((value) => value.shouldBlockInternet));

    final shouldStartDnd =
        ref.watch(bedtimeProvider.select((value) => value.shouldStartDnd));

    return MultiSliver(
      children: [
        SliverList.list(
          children: [
            /// Pause Apps
            SwitchableListTile(
              value: shouldPauseApps,
              enabled: !isScheduleOn,
              onPressed: () => _togglePauseApps(ref),
              titleText: "Pause apps",
              subTitleText: "Pause distracting apps",
            ),

            /// Pause Internet
            SwitchableListTile(
              value: shouldBlockInternet,
              enabled: !isScheduleOn,
              onPressed: () => _togglePauseInternet(ref),
              titleText: "Block internet",
              subTitleText: "Block distracting app's internet",
            ),

            /// DND Mode
            SwitchableListTile(
              value: shouldStartDnd,
              enabled: !isScheduleOn,
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
              child: const ListTileSkeleton(
                leading: Icon(FluentIcons.alert_20_regular),
                title: StatefulText(
                  "Do not disturb settings",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: StatefulText(
                  "Manage which app are distracting you from your routine.",
                  fontSize: 14,
                  isActive: false,
                ),
                trailing: Icon(FluentIcons.chevron_right_20_filled),
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
                leading: const Icon(FluentIcons.weather_moon_20_regular),
                title: const StatefulText(
                  "Distracting apps",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: const StatefulText(
                  "Manage which app are distracting you from your routine.",
                  fontSize: 14,
                ),
                trailing: AnimatedRotation(
                  duration: 250.ms,
                  turns: isDistractingAppsListExpanded ? 0.5 : 0,
                  child: const Icon(FluentIcons.chevron_down_20_filled),
                ),
              ),
            ),
          ],
        ),

        /// Distracting apps list
        SliverAnimatedPaintExtent(
          duration: 650.ms,
          curve: Curves.easeOut,
          child: isDistractingAppsListExpanded
              ? const DistractingAppsList()
              : 0.vSliverBox(),
        ),

        72.vSliverBox(),
      ],
    );
  }
}
