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
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/ui/onboarding/onboarding_screen.dart';
import 'package:mindful/ui/screens/active_session/active_session_screen.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_screen.dart';
import 'package:mindful/ui/screens/change_logs/change_logs_screen.dart';
import 'package:mindful/ui/screens/focus/focus_screen.dart';
import 'package:mindful/ui/screens/home/home_screen.dart';
import 'package:mindful/ui/screens/parental_controls/parental_controls_screen.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_groups_screen.dart';
import 'package:mindful/ui/screens/settings/settings_screen.dart';
import 'package:mindful/ui/screens/shorts_blocking/shorts_blocking_screen.dart';
import 'package:mindful/ui/screens/upcoming_notifications/upcoming_notifications_screen.dart';
import 'package:mindful/ui/screens/websites_blocking/websites_blocking_screen.dart';
import 'package:mindful/ui/splash_screen.dart';

class AppRoutes {
  static const String rootSplashPath = '/';
  static const String onboardingPath = '/onboarding';
  static const String changeLogsPath = '/changeLogs';
  static const String settingsPath = '/settings';

  static const String homePath = '/home';
  static const String activeSessionPath = '/activeSession';
  static const String focusModePath = '/focus';

  static const String parentalControlsPath = '/parentalControls';
  static const String restrictionGroupsPath = '/restrictionGroups';
  static const String shortsBlockingPath = '/shortsBlocking';
  static const String websitesBlockingPath = '/websitesBlocking';

  static const String appDashboardPath = '/appDashboard';
  static const String upcomingNotificationsPath = '/upcomingNotifications';

  static final Map<String, Widget Function(BuildContext)> routes = {
    /// Root
    rootSplashPath: (context) => const SplashScreen(),

    /// Onboarding screen
    onboardingPath: (context) => OnboardingScreen(
          isOnboardingDone:
              context.resolveParam<bool>("isOnboardingDone") ?? false,
        ),

    /// Change logs screen
    changeLogsPath: (context) => const ChangeLogsScreen(),

    /// Settings screen
    settingsPath: (context) => SettingsScreen(
          initialTabIndex: context.resolveParam<int>("tab"),
        ),

    /// Home screen
    homePath: (context) => HomeScreen(
          initialTabIndex: context.resolveParam<int>("tab"),
        ),

    /// Parental controls screen
    parentalControlsPath: (context) => const ParentalControlsScreen(),

    /// Restriction groups screen
    restrictionGroupsPath: (context) => const RestrictionGroupsScreen(),

    /// Shorts blocking screen
    shortsBlockingPath: (context) => const ShortsBlockingScreen(),

    /// Websites blocking screen
    websitesBlockingPath: (context) => const WebsitesBlockingScreen(),

    /// Upcoming notifications list screen
    upcomingNotificationsPath: (context) => const UpcomingNotificationsScreen(),

    /// Focus mode screen
    focusModePath: (context) => FocusScreen(
          initialTabIndex: context.resolveParam<int>("tab"),
        ),

    /// Active focus session screen
    activeSessionPath: (context) => const ActiveSessionScreen(),

    /// App dashboard screen
    appDashboardPath: (context) => AppDashboardScreen(
          packageName: context.resolveParam<String>("package") ?? "",
          initialUsageType:
              UsageType.values[(context.resolveParam<int>("type") ?? 0) % 2],
          selectedDay: context.resolveParam<DateTime>("day"),
        ),
  };
}
