import 'package:flutter/material.dart';
import 'package:mindful/screens/home_screen.dart';
import 'package:mindful/screens/device_time_stats_screen.dart';

class AppRoutes {
  static const String splashScreen = "/";
  static const String homeScreen = "/homeScreen";
  static const String statsScreen = "/statsScreen";

  /// map
  static Map<String, Widget Function(BuildContext)> appRoutes = {
    splashScreen: (contesxt) => const HomeScreen(),
    homeScreen: (context) => const HomeScreen(),
    statsScreen: (context) => const DeviceTimeStatsScreen(),
  };
}
