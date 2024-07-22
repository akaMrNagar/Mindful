import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/bedtime_provider.dart';
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
      WidgetRef ref, BuildContext context, bool shouldStart) async {
    final state = ref.read(bedtimeProvider);
    final isModifiable = ref.read(bedtimeProvider.notifier).isModifiable();

    if (shouldStart && state.distractingApps.isEmpty) {
      context.showSnackWarning(
        "Select at least one distracting app to turn on bedtime schedule",
      );
      return;
    } else if (!shouldStart && !isModifiable) {
      context.showSnackWarning(
        "Due to invincible mode, modifications are not allowed during the bedtime period. You can add distracting apps but cannot remove them.",
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
          ).sliverBox,

          const SliverContentTitle(title: "Schedule"),

          /// Card with start and end time for schedule
          /// also schedule days
          const ScheduleCard().sliverBox,

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
          ).sliverBox,

          8.vSliverBox,

          /// Actions related to bedtime
          const SliverQuickActions(),

          const SliverTabsBottomPadding()
        ],
      ),
    );
  }
}
