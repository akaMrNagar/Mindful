import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/home/bedtime/schedule_card.dart';
import 'package:mindful/ui/screens/home/bedtime/sliver_quick_actions.dart';

class TabBedtime extends StatelessWidget {
  const TabBedtime({super.key});

  void _setScheduleStatus(WidgetRef ref, bool shouldStart) async {
    final state = ref.read(bedtimeProvider);
    final isModifiable = ref.read(bedtimeProvider.notifier).isModifiable();

    if (shouldStart && state.distractingApps.isEmpty) {
      await MethodChannelService.instance.showToast(
        "Select atleast one distracting app",
      );

      return;
    } else if (!shouldStart && !isModifiable) {
      await MethodChannelService.instance.showToast(
        "Cannot disable schedule in invincible mode",
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
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "Bedtime"),

          /// Information about bedtime
          const StyledText(
            "Silence your phone, change screen to black and white at bedtime. Only alarms and important calls can reach you.",
          ).toSliverBox(),

          12.vSliverBox(),

          /// Card with start and end time for schedule
          /// also schedule days
          const ScheduleCard().toSliverBox(),

          8.vSliverBox(),

          /// Bedtimem schedule status toggler
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
                subtitleText: "Enable or disable daily schedule",
                onPressed: () => _setScheduleStatus(ref, !isScheduleOn),
              );
            },
          ).toSliverBox(),

          /// Actions related to bedtime
          const SliverQuickActions(),

          180.vSliverBox(),
        ],
      ),
    );
  }
}
