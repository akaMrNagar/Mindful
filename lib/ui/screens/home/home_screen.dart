import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/common/vertical_tab_bar.dart';
import 'package:mindful/ui/screens/home/bedtime/tab_bedtime.dart';
import 'package:mindful/ui/screens/home/dashboard/tab_dashboard.dart';
import 'package:mindful/ui/screens/home/protection/tab_Protection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: VerticalTabBar(
        onTabChanged: (index) => debugPrint("Tab index : $index"),
        leading: IconButton(
          icon: const Icon(FluentIcons.device_eq_20_filled),
          onPressed: () {},
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
            title: "Protection",
            icon: FluentIcons.shield_lock_20_filled,
            body: TabProtection(),
          ),
        ],
      ),
    );
  }
}
