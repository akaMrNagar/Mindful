import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/providers/bedtime_schedule_provider.dart';
import 'package:mindful/ui/widgets/custom_list_tile.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

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
    final status = !ref
        .watch(bedtimeScheduleProvider.select((value) => value.bedtimeStatus));
    final pauseApps =
        ref.watch(bedtimeScheduleProvider.select((value) => value.pauseApps));
    final dnd =
        ref.watch(bedtimeScheduleProvider.select((value) => value.enableDND));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText("Settings", size: 14),
        6.vBox(),

        /// Schedule Status
        CustomListTile(
          onPressed: () => _toggleStatus(ref),
          title: const TitleText("Status", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Enable or disable daily schedule task",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: !status,
            onChanged: (t) => _toggleStatus(ref),
          ),
        ),

        /// Pause Apps
        CustomListTile(
          onPressed: status ? () => _togglePauseApps(ref) : null,
          title: const TitleText("Pause Apps", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Pause apps with timers On",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: pauseApps,
            onChanged: status ? (t) => _togglePauseApps(ref) : null,
          ),
        ),

        /// DND Mode
        CustomListTile(
          onPressed: status ? () => _toggleDND(ref) : null,
          title: const TitleText("Do Not Disturb", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Only calls from starred contacts, \nrepeat callers and alarms can reach you",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: dnd,
            onChanged: status ? (t) => _toggleDND(ref) : null,
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
