import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/vertical_tab_bar.dart';
import 'package:mindful/ui/screens/home/bedtime/tab_bedtime.dart';
import 'package:mindful/ui/screens/home/dashboard/tab_dashboard.dart';
import 'package:mindful/ui/screens/home/wellbeing/tab_wellbeing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerticalTabBar(
        onTabChanged: (index) => debugPrint("Tab index : $index"),
        leading: Consumer(
          builder: (_, WidgetRef ref, __) {
            return IconButton(
              icon: const Icon(FluentIcons.device_eq_20_filled),
              onPressed: () =>
                  ref.read(settingsProvider.notifier).toggleThemeMode(),
            );
          },
        ),
        tabItems: [
          const VerticalTabItem(
            title: "Dashboard",
            icon: FluentIcons.data_pie_24_filled,
            body: TabDashboard(),
          ),
          VerticalTabItem(
            title: "Statistics",
            icon: FluentIcons.target_arrow_20_filled,
            body: Container(color: Colors.green),
          ),
          const VerticalTabItem(
            title: "Bedtime",
            icon: FluentIcons.sleep_20_filled,
            body: TabBedtime(),
          ),
          const VerticalTabItem(
            title: "Wellbeing",
            icon: FluentIcons.brain_circuit_20_filled,
            body: TabWellbeing(),
          ),
        ],
      ),
    );
  }
}
