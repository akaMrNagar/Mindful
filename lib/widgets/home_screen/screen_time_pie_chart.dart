import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/colors.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/device_usage_provider.dart';
import 'package:mindful/providers/apps_by_screen_time_provider.dart';
import 'package:mindful/screens/app_stats_screen.dart';
import 'package:mindful/screens/device_time_stats_screen.dart';
import 'package:mindful/widgets/_common/application_icon.dart';
import 'package:mindful/widgets/_common/async_error_indicator.dart';
import 'package:mindful/widgets/_common/async_loading_indicator.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';

final _selectedPieSecProvider = StateProvider.autoDispose<int>((ref) => -1);

class ScreenTimePieChart extends ConsumerWidget {
  const ScreenTimePieChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = dayOfWeek;
    final selectedPieSec = ref.watch(_selectedPieSecProvider);
    final totalScreenTimeToday = ref.watch(deviceUsageProvider
        .select((value) => value.deviceScreenTimeThisWeek[today]));

    return SizedBox(
      height: 264,
      child: ref.watch(appsByScreenTimeProvider(today)).when(
            error: (e, st) => AsyncErrorIndicator(e, st),
            loading: () => const AsyncLoadingIndicator(),
            data: (data) {
              final apps = data.sublist(0, min(7, data.length));
              return Stack(
                alignment: Alignment.center,
                children: [
                  /// Pie chart for birds eye view
                  RepaintBoundary(
                    child: PieChart(
                      PieChartData(
                          sectionsSpace: 4,
                          startDegreeOffset: 0,
                          centerSpaceRadius: 95,
                          sections: List.generate(apps.length, (index) {
                            final isSelected = selectedPieSec == index;
                            return PieChartSectionData(
                              radius: isSelected ? 32 : 20,
                              color: isSelected || selectedPieSec.isNegative
                                  ? pieChartColors[index]
                                  : Theme.of(context).cardColor,
                              value: apps[index]
                                  .screenTimeThisWeek[today]
                                  .toDouble(),
                              showTitle: false,
                            );
                          }),
                          pieTouchData: PieTouchData(
                            touchCallback: (touchEvent, touchResponse) {
                              if (!touchEvent.isInterestedForInteractions) {
                                final index = touchResponse
                                        ?.touchedSection?.touchedSectionIndex ??
                                    -1;
                                if (selectedPieSec != index) {
                                  ref
                                      .read(_selectedPieSecProvider.notifier)
                                      .update((state) => index);
                                }
                              }
                            },
                          )),
                      swapAnimationCurve: Curves.ease,
                      swapAnimationDuration: 250.ms,
                    ),
                  ),

                  InteractiveCard(
                    height: 164,
                    width: 164,
                    circularRadius: 90,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => selectedPieSec.isNegative
                              ? const DeviceTimeStatsScreen()
                              : AppStatsScreen(
                                  app: apps[selectedPieSec],
                                  chartIndex: 0,
                                ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Applications icon / pie chart icon
                        !selectedPieSec.isNegative
                            ? ApplicationIcon(
                                app: apps[selectedPieSec],
                                size: 24,
                              )
                            : const Icon(FluentIcons.data_pie_20_regular),

                        /// Application name / Today

                        const SizedBox(height: 2),
                        SubtitleText(
                          !selectedPieSec.isNegative
                              ? apps[selectedPieSec].name
                              : "Today",
                        ),
                        const SizedBox(height: 8),

                        /// Application Screen time / total screen time
                        TitleText(
                          selectedPieSec == -1
                              ? totalScreenTimeToday.seconds.toTime()
                              : apps[selectedPieSec]
                                  .screenTimeThisWeek[today]
                                  .seconds
                                  .toTime(),
                        ),

                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }
}
