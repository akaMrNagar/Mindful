import 'package:flutter/material.dart';
import 'package:mindful/widgets/_common/custom_app_bar.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/widgets_revealer.dart';
import 'package:mindful/widgets/home_screen/average_stats_cards.dart';
import 'package:mindful/widgets/home_screen/quick_actions.dart';
import 'package:mindful/widgets/home_screen/screen_time_pie_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: const SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(showBackBtn: false),

              /// Chart card
              ScreenTimePieChart(),
              SizedBox(height: 32),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: WidgetsRevealer(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
