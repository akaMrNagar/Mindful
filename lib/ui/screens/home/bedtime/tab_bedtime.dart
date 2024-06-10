import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/screens/home/bedtime/bedtime_card.dart';
import 'package:mindful/ui/screens/home/bedtime/bedtime_actions.dart';

class TabBedtime extends StatelessWidget {
  const TabBedtime({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: CustomScrollView(
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "Bedtime"),

          /// Information about bedtime
          const StatefulText(
            "Silence your phone, change screen to black and white at bedtime. Only alarms and important calls can reach you.",
            activeColor: Colors.grey,
          ).toSliverBox(),

          12.vSliverBox(),

          /// Card with start and end time for schedule
          /// also schedule days
          const BedtimeCard(),

          8.vSliverBox(),

          /// Bedtimem schedule status toggler
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final isScheduleOn = ref.watch(
                bedtimeProvider.select((v) => v.isScheduleOn),
              );

              return SwitchableListTile(
                isPrimary: true,
                value: isScheduleOn,
                leadingIcon: FluentIcons.sleep_20_regular,
                titleText: "Schedule",
                subTitleText: "Enable or disable daily schedule",
                onPressed: () => ref
                    .read(bedtimeProvider.notifier)
                    .toggleScheduleStatus(!isScheduleOn),
              );
            },
          ).toSliverBox(),

          /// Bedtime actions
          const SliverFlexiblePinnedHeader(
            minHeight: 32,
            maxHeight: 42,
            alignment: Alignment(-1, 0.75),
            child: Text("Quick actions"),
          ),

          /// Actions related to bedtime
          const BedtimeActions(),
        ],
      ),
    );
  }
}
