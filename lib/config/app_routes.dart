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
import 'package:mindful/ui/onboarding/onboarding_screen.dart';
import 'package:mindful/ui/screens/active_session/active_session_screen.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_screen.dart';
import 'package:mindful/ui/screens/focus/focus_screen.dart';
import 'package:mindful/ui/screens/home/home_screen.dart';
import 'package:mindful/ui/screens/batch_notifications/batch_notifications_screen.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_groups_screen.dart';
import 'package:mindful/ui/screens/settings/settings_screen.dart';
import 'package:mindful/ui/screens/upcoming_notifications/upcoming_notifications_screen.dart';
import 'package:mindful/ui/splash_screen.dart';

/// Parameters passed to [AppDashboardScreen] when using push named
@immutable
class AppDashboardParams {
  final String packageName;
  final UsageType? initialUsageType;
  final DateTime? selectedDay;

  const AppDashboardParams({
    required this.packageName,
    this.initialUsageType,
    this.selectedDay,
  });
}

class AppRoutes {
  static const String splashScreen = '/';
  static const String homeScreen = '/homeScreen';
  static const String onboardingScreen = '/onboardingScreen';
  static const String appDashboardScreen = '/appDashboardScreen';
  static const String settingsScreen = '/mindfulSettingsScreen';
  static const String restrictionGroupsScreen = '/restrictionGroupsScreen';
  static const String batchNotificationsScreen = '/batchNotificationsScreen';
  static const String upcomingNotificationsScreen =
      '/upcomingNotificationsScreen';
  static const String focusScreen = '/focusScreen';
  static const String activeSessionScreen = '/activeSessionScreen';

  static final routes = {
    splashScreen: (context) => const SplashScreen(),
    homeScreen: (context) => const HomeScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    restrictionGroupsScreen: (context) => const RestrictionGroupsScreen(),
    batchNotificationsScreen: (context) => const BatchNotificationsScreen(),
    upcomingNotificationsScreen: (context) =>
        const UpcomingNotificationsScreen(),

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
          ModalRoute.of(context)?.settings.arguments as AppDashboardParams;

      return AppDashboardScreen(
        packageName: args.packageName,
        initialUsageType: args.initialUsageType,
        selectedDay: args.selectedDay,
      );
    }
  };
}
