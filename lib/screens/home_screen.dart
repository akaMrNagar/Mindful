import 'package:flutter/material.dart';
import 'package:mindful/widgets/shared/app_bar.dart';
import 'package:mindful/widgets/shared/custom_text.dart';
import 'package:mindful/widgets/shared/widgets_revealer.dart';
import 'package:mindful/widgets/home_screen/average_stats_cards.dart';
import 'package:mindful/widgets/home_screen/quick_actions.dart';
import 'package:mindful/widgets/home_screen/screen_time_pie_chart.dart';

/// Home screen of MINDFUL app
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const MindfulAppBar(isHome: true, floating: false),
          SliverList.list(
            children: const [
              /// Chart card
              ScreenTimePieChart(),
              SizedBox(height: 32),

              WidgetsRevealer(
                baseDelay: 50,
                childDelay: 150,
                animDuration: 750,
                children: [
                  /// Quick actions
                  TitleText("Quick actions"),
                  SizedBox(height: 8),
                  QuickActions(),
                  SizedBox(height: 16),

                  /// Average screen usage
                  TitleText("Usage Average"),
                  SizedBox(height: 8),
                  AverageStatsCards(),
                  SizedBox(height: 16),

                  /// Danger Zone
                  TitleText("Danger zone"),
                  SizedBox(height: 8),
                  // DangerZone(),
                  SizedBox(height: 16),

                  SizedBox(height: 500),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
