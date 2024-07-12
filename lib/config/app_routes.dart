import 'package:flutter/material.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_screen.dart';
import 'package:mindful/ui/screens/app_dashboard_routing_screen.dart';
import 'package:mindful/ui/screens/home/home_screen.dart';
import 'package:mindful/ui/screens/settings/settings_screen.dart';

class AppRoutes {
  static const String homeScreen = '/';
  static const String appDashboardScreen = '/appDashboardScreen';
  static const String settingsScreen = '/mindfulSettingsScreen';
  static const String appDashboardRoutingScreen = '/appDashboardRoutingScreen';

  static final routes = {
    appDashboardRoutingScreen: (context) => const AppDashboardRoutingScreen(),
    homeScreen: (context) => const HomeScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    appDashboardScreen: (context) => AppDashboardScreen(
          app: ModalRoute.of(context)?.settings.arguments as AndroidApp,
        ),
  };
}
