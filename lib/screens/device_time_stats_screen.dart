import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/providers/apps_by_screen_time_provider.dart';
import 'package:mindful/providers/device_usage_provider.dart';
import 'package:mindful/providers/selected_day_provider.dart';
import 'package:mindful/widgets/shared/app_bar.dart';
import 'package:mindful/widgets/shared/application_tile.dart';
import 'package:mindful/widgets/shared/async_error_indicator.dart';
import 'package:mindful/widgets/shared/async_loading_indicator.dart';
import 'package:mindful/widgets/shared/base_bar_chart.dart';
import 'package:mindful/widgets/shared/custom_text.dart';
import 'package:mindful/widgets/shared/widgets_revealer.dart';

/// Screen which displays aggregated device screen time usage and list of apps
/// whose screen time is more than 0 seconds.
class DeviceTimeStatsScreen extends StatelessWidget {
  const DeviceTimeStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const MindfulAppBar(title: "Screen time"),
          SliverList.list(
            children: [
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  final day = ref.watch(selectedDayProvider);
                  final deviceTime = ref.watch(deviceUsageProvider
                      .select((value) => value.deviceScreenTimeThisWeek));
                  final usedApps = ref.watch(appsByScreenTimeProvider(day));

                  return WidgetsRevealer(
                    children: [
                      /// Total Screen usage on selected day
                      Center(
                        child: TitleText(
                          deviceTime[day].seconds.toTime(),
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 2),

                      /// Date
                      Center(child: SubtitleText(day.toDateDiffToday())),
                      const SizedBox(height: 48),

                      /// This week's screen usage bar chart
                      SizedBox(
                        height: 256,
                        child: BaseBarChart(
                          selectedDay: day,
                          data: deviceTime,
                          intervalBuilder: (max) => max * 0.25,
                          sideLabelsBuilder: (seconds) => (seconds >= 3600)
                              ? "${(seconds / 3600).ceil()}h"
                              : "${(seconds / 60).ceil()}m",
                        ),
                      ),

                      const SizedBox(height: 32),
                      const TitleText(AppStrings.mostUsedApps),
                      const SizedBox(height: 8),

                      /// List of most used apps filtered by their screen time
                      ...usedApps.when(
                        error: (e, st) => [AsyncErrorIndicator(e, st)],
                        loading: () => [const AsyncLoadingIndicator()],
                        data: (data) => data
                            .map(
                              (e) => ApplicationTile(
                                app: e,
                                isDataTile: false,
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
        ],
      ),
    );
  }
}
