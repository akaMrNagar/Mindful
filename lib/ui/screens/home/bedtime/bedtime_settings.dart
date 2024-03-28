import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/providers/bedtime_schedule_provider.dart';
import 'package:mindful/ui/common/components/switchable_list_tile.dart';
import 'package:mindful/ui/common/custom_text.dart';

class BedtimeSettings extends ConsumerWidget {
  const BedtimeSettings({super.key});

  void _toggleStatus(WidgetRef ref) =>
      ref.read(bedtimeScheduleProvider.notifier).toggleBedtimeStatus();

  void _togglePauseApps(WidgetRef ref) =>
      ref.read(bedtimeScheduleProvider.notifier).togglePauseApps();

  void _toggleDND(WidgetRef ref) =>
      ref.read(bedtimeScheduleProvider.notifier).toggleDND();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bedtimeEnabled = ref
        .watch(bedtimeScheduleProvider.select((value) => value.bedtimeStatus));
    final pauseApps =
        ref.watch(bedtimeScheduleProvider.select((value) => value.pauseApps));
    final dnd =
        ref.watch(bedtimeScheduleProvider.select((value) => value.enableDND));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Schedule Status
        SwitchableListTile(
          value: bedtimeEnabled,
          onPressed: () => _toggleStatus(ref),
          title: const TitleText("Status", weight: FontWeight.normal),
          subTitle: const SubtitleText("Enable or disable daily schedule task"),
        ),

        /// Pause Apps
        SwitchableListTile(
          value: pauseApps,
          enabled: !bedtimeEnabled,
          onPressed: () => _togglePauseApps(ref),
          title: const TitleText("Pause Apps", weight: FontWeight.normal),
          subTitle: const SubtitleText("Pause apps with timers On"),
        ),

        /// DND Mode
        SwitchableListTile(
          value: dnd,
          enabled: !bedtimeEnabled,
          onPressed: () => _toggleDND(ref),
          title: const TitleText("Do Not Disturb", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Only calls from starred contacts, \nrepeat callers and alarms can reach you",
          ),
        ),

        ElevatedButton(
          onPressed: () {
            MindfulNativePlugin.instance.startVpnService();
          },
          child: const Text("Connect"),
        ),
        ElevatedButton(
          onPressed: () {
            MindfulNativePlugin.instance.stopVpnService();
          },
          child: const Text("Disconnect"),
        ),
        ElevatedButton(
          onPressed: () {
            MindfulNativePlugin.instance.startTrackingService();
          },
          child: const Text("Start Tracking"),
        ),
        ElevatedButton(
          onPressed: () {
            MindfulNativePlugin.instance.stopTrackingService();
          },
          child: const Text("Stop Tracking"),
        ),
      ],
    );
  }
}
