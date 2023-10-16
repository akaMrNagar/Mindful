import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/widgets/_common/base_bar_chart.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/data_usage_info.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';

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
            intervalBuilder: (max) => max < 60 ? 60 : null,
            sideLabelsBuilder: (seconds) => (seconds >= 3600)
                ? "${(seconds / 3600).ceil()}h"
                : "${(seconds / 60).ceil()}m",
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
              intervalBuilder: (max) => null,
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
