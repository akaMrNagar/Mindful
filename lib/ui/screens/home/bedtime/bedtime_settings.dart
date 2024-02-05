import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/schedule_provider.dart';
import 'package:mindful/ui/widgets/custom_list_tile.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

class BedtimeSettings extends ConsumerWidget {
  const BedtimeSettings({super.key});

  void _toggleStatus(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleBedtimeStatus();

  void _toggleInvincible(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleInvincibleMode();

  void _togglePauseApps(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).togglePauseApps();

  void _toggleDND(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleDND();

  void _toggleGreScale(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleGreyScale();

  void _toggleDarkTheme(WidgetRef ref) =>
      ref.read(bedtimeProvider.notifier).toggleDarkTheme();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status =
        ref.watch(bedtimeProvider.select((value) => value.bedtimeStatus));

    final invincible =
        ref.watch(bedtimeProvider.select((value) => value.invincible));

    final modifiable = status && !invincible;

    final pauseApps =
        ref.watch(bedtimeProvider.select((value) => value.pauseApps));

    final dnd = ref.watch(bedtimeProvider.select((value) => value.dnd));

    final greyScale =
        ref.watch(bedtimeProvider.select((value) => value.greyScale));

    final darkTheme =
        ref.watch(bedtimeProvider.select((value) => value.darkTheme));

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

        /// Invincible mode
        CustomListTile(
          onPressed: status ? () => _toggleInvincible(ref) : null,
          title: const TitleText("Invincible Mode", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "If enbled, you cannot modify bedtime \nsettings if schedule is active.",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: invincible,
            onChanged: status ? (t) => _toggleInvincible(ref) : null,
          ),
        ),

        /// Pause Apps
        CustomListTile(
          onPressed: modifiable ? () => _togglePauseApps(ref) : null,
          title: const TitleText("Pause Apps", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Pause apps whose timers are running",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: pauseApps,
            onChanged: modifiable ? (t) => _togglePauseApps(ref) : null,
          ),
        ),

        /// DND Mode
        CustomListTile(
          onPressed: modifiable ? () => _toggleDND(ref) : null,
          title: const TitleText("Do Not Disturb", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Only calls from starred contacts, \nrepeat callers and alarms can reach you",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: dnd,
            onChanged: modifiable ? (t) => _toggleDND(ref) : null,
          ),
        ),

        /// Greyscale mode
        CustomListTile(
          onPressed: modifiable ? () => _toggleGreScale(ref) : null,
          title: const TitleText("Greyscale", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Change the screen to black and white",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: greyScale,
            onChanged: modifiable ? (t) => _toggleGreScale(ref) : null,
          ),
        ),

        /// Dark Theme
        CustomListTile(
          onPressed: modifiable ? () => _toggleDarkTheme(ref) : null,
          title: const TitleText("Dark theme", weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Enable dark theme at night",
          ),
          trailing: Switch(
            activeColor: const Color(0xFF0EABE1),
            value: darkTheme,
            onChanged: modifiable ? (t) => _toggleDarkTheme(ref) : null,
          ),
        ),
      ],
    );
  }
}
