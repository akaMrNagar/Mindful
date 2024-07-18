import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/screens/home/bedtime/tab_bedtime.dart';
import 'package:mindful/ui/screens/home/dashboard/tab_dashboard.dart';
import 'package:mindful/ui/screens/home/statistics/tab_statistics.dart';
import 'package:mindful/ui/screens/home/wellbeing/tab_wellbeing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultNavbar(
        leading: IconButton(
          icon: const Icon(FluentIcons.device_eq_20_filled),
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoutes.settingsScreen),
        ),
        navbarItems: const [
          NavbarItem(
            title: "Dashboard",
            icon: FluentIcons.data_treemap_20_filled,
            body: TabDashboard(),
          ),
          NavbarItem(
            title: "Statistics",
            icon: FluentIcons.data_pie_24_filled,
            body: TabStatistics(),
          ),
          NavbarItem(
            title: "Bedtime",
            icon: FluentIcons.sleep_20_filled,
            body: TabBedtime(),
          ),
          NavbarItem(
            title: "Wellbeing",
            icon: FluentIcons.brain_circuit_20_filled,
            body: TabWellBeing(),
          ),
        ],
      ),
    );
  }
}
