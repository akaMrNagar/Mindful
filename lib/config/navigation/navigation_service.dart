/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/config/navigation/app_routes_observer.dart';
import 'package:mindful/initializer.dart';

/// A service class responsible for handling deep link and navigation to different routes externally without widget ui.
class NavigationService {
  /// Private constructor to enforce singleton pattern.
  NavigationService._();

  /// Singleton instance of the [NavigationService].
  static final NavigationService instance = NavigationService._();

  /// Global key used for navigation
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // NOTE: To test  => adb shell am start -W -a android.intent.action.VIEW -d "com.mindful.android://open/settings?tab=1" com.mindful.android.debug
  /// App links package instance
  final _appLinks = AppLinks();

  /// Go to the initial screen after the splash screen.
  /// Forwards user to desired screen if initial deep link have path
  /// otherwise to home screen.
  ///
  /// Should be called from splash screen after authentication if access is protected
  /// or Onboarding Screen after setup
  Future<void> init({required bool showChangeLogsToo}) async {
    /// Initialize services after a delay to prevent app from lagging
    Future.delayed(10.seconds, Initializer.initializeServicesAndSchedules);

    /// Listen to changes and handle deep links when their is a valid link either on app startup
    /// or even when app is active.
    _appLinks.uriLinkStream.listen(
      (uri) {
        if (AppRoutes.routes.keys.contains(uri.path)) {
          _goToRoute(
            uri.path,
            parameters: uri.queryParameters,
          );
        }
      },
    );

    /// Fetch initial deep link
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri == null) {
      await _goToRoute(AppRoutes.homePath, replaceCurrent: true);
    }

    /// Now push the changelog screen if needed
    if (showChangeLogsToo) {
      await Future.delayed(5.seconds);
      await _goToRoute(AppRoutes.changeLogsPath);
    }
  }

  /// Forwards or push the new route with the arguments based on the [replaceCurrent].
  /// It checks the current route before pushing the new route and guarantee
  /// no duplicate routes on top of each other.
  ///
  /// If [replaceCurrent] is TRUE the route is replaced otherwise pushed to the current route
  Future<void> _goToRoute(
    String routePath, {
    Map<String, String>? parameters,
    bool replaceCurrent = false,
  }) async {
    try {
      /// If mounted to any widgets
      if (!(navigatorKey.currentState?.mounted ?? false)) return;

      // Get the current route
      final currentRoute = AppRoutesObserver.instance.currentRoute;

      if (!replaceCurrent &&
          currentRoute != routePath &&
          currentRoute != AppRoutes.rootSplashPath) {
        /// Push on top
        navigatorKey.currentState?.pushNamed(
          routePath,
          arguments: parameters,
        );
      } else {
        /// Replace top
        navigatorKey.currentState?.pushReplacementNamed(
          routePath,
          arguments: parameters,
        );
      }
    } catch (e) {
      debugPrint("NavigationService._goToRoute(): Error while navigating: $e");
    }
  }
}
