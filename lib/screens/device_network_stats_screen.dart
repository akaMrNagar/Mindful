import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/providers/apps_by_data_usage_provider.dart';
import 'package:mindful/providers/device_usage_provider.dart';
import 'package:mindful/providers/selected_day_provider.dart';
import 'package:mindful/widgets/_common/application_tile.dart';
import 'package:mindful/widgets/_common/async_error_indicator.dart';
import 'package:mindful/widgets/_common/async_loading_indicator.dart';
import 'package:mindful/widgets/_common/base_bar_chart.dart';
import 'package:mindful/widgets/_common/custom_app_bar.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/data_usage_info.dart';
import 'package:mindful/widgets/_common/widgets_revealer.dart';

class DeviceNetworkStatsScreen extends StatelessWidget {
  const DeviceNetworkStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// app bar
              const CustomAppBar(),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final deviceUsage = ref.watch(deviceUsageProvider);
                    final day = ref.watch(selectedDayProvider);
                    final usedApps = ref.watch(appsByDataUsageProvider(day));

                    return WidgetsRevealer(
                      children: [
                        /// This week's screen usage bar chart
                        Center(
                          child: TitleText(
                            deviceUsage.deviceDataUsageThisWeek[day].toData(),
                            size: 24,
                          ),
                        ),

                        const SizedBox(height: 2),
                        Center(child: SubtitleText(day.toDateDiffToday())),

                        const SizedBox(height: 48),
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
                        DataUsageInfo(
                          mobile: deviceUsage.deviceMobileUsageThisWeek[day],
                          wifi: deviceUsage.deviceWifiUsageThisWeek[day],
                        ),

                        const SizedBox(height: 24),
                        const TitleText("Most used apps"),
                        const SizedBox(height: 8),

                        /// Apps List
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
