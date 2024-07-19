import 'package:flutter/material.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_screen.dart';
import 'package:mindful/ui/screens/home/home_screen.dart';
import 'package:mindful/ui/screens/settings/settings_screen.dart';

/// Arguments used in the family provider to sort and filter apps package based on these args.
/// Mainly used by [packagesByScreenUsageProvider] and [packagesByNetworkUsageProvider].
/// Args contains bool [includeAll] and int [selectedDayOfWeek]
typedef FilterArgs = ({
  bool includeAll,
  int selectedDoW,
});

/// Arguments used in app routes to fetch necessary data from push named routes
typedef AppDashboardScreenArgs = ({
  AndroidApp app,
  UsageType selectedUsageType,
  int selectedDoW,
});

class AppRoutes {
  static const String homeScreen = '/';
  static const String appDashboardScreen = '/appDashboardScreen';
  static const String settingsScreen = '/mindfulSettingsScreen';

  static final routes = {
    homeScreen: (context) => const HomeScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    appDashboardScreen: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments as AppDashboardScreenArgs;

      return AppDashboardScreen(
        app: args.app,
        usageType: args.selectedUsageType,
        selectedDoW: args.selectedDoW,
      );
    }
  };
}
