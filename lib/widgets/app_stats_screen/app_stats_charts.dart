import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/widgets/shared/base_bar_chart.dart';
import 'package:mindful/widgets/shared/custom_text.dart';
import 'package:mindful/widgets/shared/data_usage_info.dart';
import 'package:mindful/widgets/shared/interactive_card.dart';

/// Screen usage bar chart for specific app
class AppScreenTimeChart extends StatelessWidget {
  const AppScreenTimeChart({
    super.key,
    required this.app,
    required this.day,
  });

  final AndroidApp app;
  final int day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(children: [
        SizedBox(
          height: 232,
          child: BaseBarChart(
            selectedDay: day,
            data: app.screenTimeThisWeek,
            intervalBuilder: (max) =>
                max.inMinutes > 1 ? (1 + (max * 0.35)) : 3600,
            sideLabelsBuilder: (seconds) => (seconds.inHours > 1)
                ? "${(seconds.inHours).round()}h"
                : "${seconds.inMinutes}m",
          ),
        ),
        const SizedBox(height: 24),
        InteractiveCard(
          height: 64,
          applyBorder: true,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(FluentIcons.phone_screen_time_20_regular),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SubtitleText("Screen Time"),
                  TitleText(app.screenTimeThisWeek[day].seconds.toTimeFull()),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

/// Data usage bar chart for specific app
class AppDataUsageChart extends StatelessWidget {
  const AppDataUsageChart({
    super.key,
    required this.app,
    required this.day,
  });

  final AndroidApp app;
  final int day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        children: [
          SizedBox(
            height: 232,
            child: BaseBarChart(
              selectedDay: day,
              data: app.dataUsageThisWeek,
              intervalBuilder: (max) => max * 0.275,
              sideLabelsBuilder: (kb) => (kb.gb >= 1)
                  ? "${kb.gb.round()}gb"
                  : (kb.mb >= 1)
                      ? "${kb.mb}mb"
                      : "${kb}kb",
            ),
          ),
          const SizedBox(height: 24),
          DataUsageInfo(
            mobile: app.mobileUsageThisWeek[day],
            wifi: app.wifiUsageThisWeek[day],
          ),
        ],
      ),
    );
  }
}
