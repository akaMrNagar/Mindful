import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/providers/aggregated_usage_provider.dart';
import 'package:mindful/providers/selected_day_provider.dart';
import 'package:mindful/providers/sorted_apps_provider.dart';
import 'package:mindful/ui/screens/home/dashboard/apps_list.dart';
import 'package:mindful/ui/widgets/custom_text.dart';
import 'package:mindful/ui/widgets/segmented_icon_buttons.dart';
import 'package:mindful/ui/widgets/base_bar_chart.dart';
import 'package:mindful/ui/widgets/usage_info_cards.dart';

class TabDashboard extends ConsumerWidget {
  const TabDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Refreshhed");
    final selectedDayBar = ref.watch(selectedDayProvider);
    final sortByTime = ref.watch(sortByTimeProvider);
    final aggregatedUsage = ref.watch(aggregatedUsageProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Padded content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Date
              SubtitleText(selectedDayBar.toDateDiffToday(), size: 14),
              const SizedBox(height: 24),
              SegmentedIconButton(
                selected: sortByTime ? 0 : 1,
                segments: const [
                  FluentIcons.phone_screen_time_20_regular,
                  FluentIcons.earth_20_regular,
                ],
                onChange: (value) => ref
                    .read(sortByTimeProvider.notifier)
                    .update((state) => value == 0),
              ),
              const SizedBox(height: 48),

              /// Usage Bar Chart
              SizedBox(
                height: 232,
                child: BaseBarChart(
                  isTimeChart: sortByTime,
                  selectedBar: selectedDayBar,
                  intervalBuilder: (max) => max * 0.275,
                  onBarTap: (barIndex) => ref
                      .read(selectedDayProvider.notifier)
                      .update((state) => barIndex),
                  data: sortByTime
                      ? aggregatedUsage.screenTimeThisWeek
                      : aggregatedUsage.networkUsageThisWeek,
                ),
              ),

              const SizedBox(height: 12),

              sortByTime
                  ? UsageInfoCard(
                      label: "Screen time",
                      info: aggregatedUsage
                          .screenTimeThisWeek[selectedDayBar].seconds
                          .toTimeFull(),
                      iconData: FluentIcons.phone_screen_time_20_regular,
                    )
                  : DataUsageInfoCard(
                      mobile:
                          aggregatedUsage.mobileUsageThisWeek[selectedDayBar],
                      wifi: aggregatedUsage.wifiUsageThisWeek[selectedDayBar],
                    ),
            ],
          ),
        ),

        const SizedBox(height: 24),
        Text(
          "Most used apps",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 12),

        /// Apps list
        AppsList(selectedDay: selectedDayBar, sortByTime: sortByTime),

        const SizedBox(height: 20),
      ],
    );
  }
}
