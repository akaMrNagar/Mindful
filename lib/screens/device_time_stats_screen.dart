import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/providers/apps_by_screen_time_provider.dart';
import 'package:mindful/providers/device_usage_provider.dart';
import 'package:mindful/providers/selected_day_provider.dart';
import 'package:mindful/widgets/_common/application_tile.dart';
import 'package:mindful/widgets/_common/async_error_indicator.dart';
import 'package:mindful/widgets/_common/async_loading_indicator.dart';
import 'package:mindful/widgets/_common/base_bar_chart.dart';
import 'package:mindful/widgets/_common/custom_app_bar.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/widgets_revealer.dart';

class DeviceTimeStatsScreen extends StatelessWidget {
  const DeviceTimeStatsScreen({super.key});

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
                    final day = ref.watch(selectedDayProvider);
                    final deviceTime = ref.watch(deviceUsageProvider
                        .select((value) => value.deviceScreenTimeThisWeek));
                    final usedApps = ref.watch(appsByScreenTimeProvider(day));

                    return WidgetsRevealer(
                      children: [
                        /// This week's screen usage bar chart
                        Center(
                          child: TitleText(
                            deviceTime[day].seconds.toTime(),
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
                            data: deviceTime,
                            sideLabelsBuilder: (seconds) => (seconds >= 3600)
                                ? "${(seconds / 3600).ceil()}h"
                                : "${(seconds / 60).ceil()}m",
                          ),
                        ),

                        const SizedBox(height: 32),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
