import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';

class BedtimeActions extends ConsumerWidget {
  const BedtimeActions({super.key});

  void _togglePauseApps(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleScreenLockdown();

  void _togglePauseInternet(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleInternetLockdown();

  void _toggleDND(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleDND();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScheduleActive =
        ref.watch(bedtimeProvider.select((value) => value.scheduleStatus));

    final pauseApps =
        ref.watch(bedtimeProvider.select((value) => value.startScreenLockdown));

    final pauseInternet = ref
        .watch(bedtimeProvider.select((value) => value.startInternetLockdown));

    final startDnd =
        ref.watch(bedtimeProvider.select((value) => value.startDnd));

    return SliverList.list(
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
              "Only calls from starred contacts, \nrepeat callers and alarms can reach you",
        ),
      ],
    );
  }
}
