import 'package:flutter/material.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/models/isar/focus_session.dart';
import 'package:mindful/ui/onboarding/onboarding_screen.dart';
import 'package:mindful/ui/screens/active_session/active_session_screen.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_screen.dart';
import 'package:mindful/ui/screens/focus/focus_screen.dart';
import 'package:mindful/ui/screens/home/home_screen.dart';
import 'package:mindful/ui/screens/settings/settings_screen.dart';
import 'package:mindful/ui/splash_screen.dart';

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
  static const String splashScreen = '/splashScreen';
  static const String onboardingScreen = '/onboardingScreen';
  static const String appDashboardScreen = '/appDashboardScreen';
  static const String settingsScreen = '/mindfulSettingsScreen';
  static const String focusScreen = '/focusScreen';
  static const String activeSessionScreen = '/activeSessionScreen';

  static final routes = {
    splashScreen: (context) => const SplashScreen(),
    onboardingScreen: (context) => const OnboardingScreen(),
    homeScreen: (context) => const HomeScreen(),
    settingsScreen: (context) => const SettingsScreen(),

    /// Resolve initial tab index from arguments
    focusScreen: (context) => FocusScreen(
          initialTabIndex: ModalRoute.of(context)?.settings.arguments as int,
        ),

    /// Resolve [FocusSession] model from arguments
    activeSessionScreen: (context) {
      final session =
          ModalRoute.of(context)?.settings.arguments as FocusSession;
      return ActiveSessionScreen(session: session);
    },

    /// Resolve variables from arguments
    appDashboardScreen: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments as AppDashboardScreenArgs;

      return AppDashboardScreen(
        app: args.app,
        initialUsageType: args.selectedUsageType,
        selectedDoW: args.selectedDoW,
      );
    }
  };
}
