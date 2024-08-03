import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/screens/home/bedtime/schedule_card.dart';
import 'package:mindful/ui/screens/home/bedtime/sliver_quick_actions.dart';

class TabBedtime extends StatelessWidget {
  const TabBedtime({super.key});

  void _setScheduleStatus(
    WidgetRef ref,
    BuildContext context,
    bool shouldStart,
  ) async {
    final state = ref.read(bedtimeProvider);

    // If the total duration is less than 30 minutes
    if (state.totalDuration.inMinutes < 30) {
      context.showSnackAlert(
        "The total bedtime duration must be at least 30 minutes.",
      );
      return;
    }

    // If no distracting apps selected
    if (shouldStart && state.distractingApps.isEmpty) {
      context.showSnackAlert(
        "Select at least one distracting app to turn on bedtime schedule",
      );
      return;
    }

    final isInvincibleModeOn = ref.read(settingsProvider).isInvincibleModeOn;
    final isModifiable =
        ref.read(bedtimeProvider.notifier).isModifiable(isInvincibleModeOn);

    // If schedule is on along with invincible mode and time now is between bedtime period
    if (!shouldStart && !isModifiable) {
      context.showSnackAlert(
        "Due to invincible mode, the bedtime schedule cannot be altered until the designated bedtime period has ended",
      );
      return;
    }

    ref.read(bedtimeProvider.notifier).switchBedtimeSchedule(shouldStart);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "Bedtime"),

          /// Information about bedtime
          const StyledText(
            "Set your bedtime schedule by selecting a time period and days of the week. Choose distracting apps to block and enable Do Not Disturb (DND) mode for a peaceful night.",
          ).sliver,

          const SliverContentTitle(title: "Schedule"),

          /// Card with start and end time for schedule
          /// also schedule days
          const ScheduleCard().sliver,

          8.vSliverBox,

          /// Bedtime schedule status toggler
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final isScheduleOn = ref.watch(
                bedtimeProvider.select((v) => v.isScheduleOn),
              );

              return DefaultListTile(
                isPrimary: true,
                switchValue: isScheduleOn,
                leadingIcon: FluentIcons.sleep_20_regular,
                titleText: "Schedule",
                subtitleText: "Enable or disable daily schedule.",
                onPressed: () => _setScheduleStatus(
                  ref,
                  context,
                  !isScheduleOn,
                ),
              );
            },
          ).sliver,

          8.vSliverBox,

          /// Actions related to bedtime
          const SliverQuickActions(),

          const SliverTabsBottomPadding()
        ],
      ),
    );
  }
}
