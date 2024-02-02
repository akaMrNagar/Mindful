import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/schedule_provider.dart';
import 'package:mindful/ui/widgets/custom_list_tile.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

class BedtimeSettings extends ConsumerWidget {
  const BedtimeSettings({super.key});

  void _toggleStatus(WidgetRef ref) =>
      ref.read(scheduleProvider.notifier).toggleStatus();

  void _toggleDND(WidgetRef ref) =>
      ref.read(scheduleProvider.notifier).toggleDND();

  void _toggleGreScale(WidgetRef ref) =>
      ref.read(scheduleProvider.notifier).toggleGreyScale();

  void _toggleDarkTheme(WidgetRef ref) =>
      ref.read(scheduleProvider.notifier).toggleDarkTheme();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(scheduleProvider.select((value) => value.status));
    final dnd = ref.watch(scheduleProvider.select((value) => value.dnd));
    final greyScale =
        ref.watch(scheduleProvider.select((value) => value.greyScale));
    final darkTheme =
        ref.watch(scheduleProvider.select((value) => value.darkTheme));

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
            value: status,
            onChanged: (t) => _toggleStatus(ref),
          ),
        ),

        /// DND Mode
        CustomListTile(
          onPressed: () => _toggleDND(ref),
          title: const TitleText("Do Not Disturb", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Only calls from starred contacts, \nrepeat callers and alarms can reach you",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: dnd,
            onChanged: (t) => _toggleDND(ref),
          ),
        ),

        /// Greyscale mode
        CustomListTile(
          onPressed: () => _toggleGreScale(ref),
          title: const TitleText("Greyscale", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Change the screen to black and white",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: greyScale,
            onChanged: (t) => _toggleGreScale(ref),
          ),
        ),

        /// Dark Theme
        CustomListTile(
          onPressed: () => _toggleDarkTheme(ref),
          title: const TitleText("Dark theme", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Enable dark theme at night",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: darkTheme,
            onChanged: (t) => _toggleDarkTheme(ref),
          ),
        ),
      ],
    );
  }
}
