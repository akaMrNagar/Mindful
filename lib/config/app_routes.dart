/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/ui/onboarding/onboarding_screen.dart';
import 'package:mindful/ui/screens/active_session/active_session_screen.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_screen.dart';
import 'package:mindful/ui/screens/focus/focus_screen.dart';
import 'package:mindful/ui/screens/home/home_screen.dart';
import 'package:mindful/ui/screens/batch_notifications/batch_notifications_screen.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_groups_screen.dart';
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
  static const String splashScreen = '/';
  static const String homeScreen = '/homeScreen';
  static const String onboardingScreen = '/onboardingScreen';
  static const String appDashboardScreen = '/appDashboardScreen';
  static const String settingsScreen = '/mindfulSettingsScreen';
  static const String restrictionGroupsScreen = '/restrictionGroupsScreen';
  static const String batchNotificationsScreen = '/batchNotificationsScreen';
  static const String focusScreen = '/focusScreen';
  static const String activeSessionScreen = '/activeSessionScreen';

  static final routes = {
    splashScreen: (context) => const SplashScreen(),
    homeScreen: (context) => const HomeScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    restrictionGroupsScreen: (context) => const RestrictionGroupsScreen(),
    batchNotificationsScreen: (context) => const BatchNotificationsScreen(),

    /// Resolve isOnboardingDone bool from arguments
    onboardingScreen: (context) => OnboardingScreen(
          isOnboardingDone: ModalRoute.of(context)?.settings.arguments as bool,
        ),

    /// Resolve [FocusSession] model from arguments
    activeSessionScreen: (context) {
      final session =
          ModalRoute.of(context)?.settings.arguments as FocusSession;
      return ActiveSessionScreen(session: session);
    },

    /// Resolve initial tab index from arguments
    focusScreen: (context) => FocusScreen(
          initialTabIndex: ModalRoute.of(context)?.settings.arguments as int,
        ),

    /// Resolve [AppDashboardScreenArgs] from arguments
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
