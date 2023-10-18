import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/providers/apps_by_data_usage_provider.dart';
import 'package:mindful/providers/device_usage_provider.dart';
import 'package:mindful/providers/selected_day_provider.dart';
import 'package:mindful/widgets/shared/app_bar.dart';
import 'package:mindful/widgets/shared/application_tile.dart';
import 'package:mindful/widgets/shared/async_error_indicator.dart';
import 'package:mindful/widgets/shared/async_loading_indicator.dart';
import 'package:mindful/widgets/shared/base_bar_chart.dart';
import 'package:mindful/widgets/shared/custom_text.dart';
import 'package:mindful/widgets/shared/data_usage_info.dart';
import 'package:mindful/widgets/shared/widgets_revealer.dart';

/// Screen which displays aggregated device network usage and list of apps
/// whose network usage is more than 0KB
class DeviceNetworkStatsScreen extends StatelessWidget {
  const DeviceNetworkStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        const MindfulAppBar(title: "Data usage"),
        SliverList.list(
          children: [
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final deviceUsage = ref.watch(deviceUsageProvider);
                final day = ref.watch(selectedDayProvider);
                final usedApps = ref.watch(appsByDataUsageProvider(day));

                return WidgetsRevealer(
                  children: [
                    /// Total data usage on selected day
                    Center(
                      child: TitleText(
                        deviceUsage.deviceDataUsageThisWeek[day].toData(),
                        size: 24,
                      ),
                    ),

                    const SizedBox(height: 2),

                    /// Date
                    Center(child: SubtitleText(day.toDateDiffToday())),
                    const SizedBox(height: 48),

                    /// This week's device data usage bar chart
                    SizedBox(
                      height: 256,
                      child: BaseBarChart(
                        selectedDay: day,
                        data: deviceUsage.deviceDataUsageThisWeek,
                        intervalBuilder: (max) => max * 0.25,
                        sideLabelsBuilder: (kb) => (kb.gb >= 1)
                            ? "${kb.gb.round()}gb"
                            : (kb.mb >= 1)
                                ? "${kb.mb}mb"
                                : "${kb}kb",
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// Info cards for wifi and mobile usage
                    DataUsageInfo(
                      mobile: deviceUsage.deviceMobileUsageThisWeek[day],
                      wifi: deviceUsage.deviceWifiUsageThisWeek[day],
                    ),

                    const SizedBox(height: 24),
                    const TitleText(AppStrings.mostUsedApps),
                    const SizedBox(height: 8),

                    /// List of most used apps filtered by data usage
                    ...usedApps.when(
                      error: (e, st) => [AsyncErrorIndicator(e, st)],
                      loading: () => [const AsyncLoadingIndicator()],
                      data: (data) => data
                          .map(
                            (e) => ApplicationTile(
                              app: e,
                              isDataTile: true,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 32),
                  ],
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
