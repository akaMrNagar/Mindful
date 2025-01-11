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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/services/method_channel_service.dart';

/// A service class responsible for routing to different screen at the time of startup.
class RoutingService {
  /// Private constructor to enforce singleton pattern.
  RoutingService._();

  /// Singleton instance of the [RoutingService].
  static final RoutingService instance = RoutingService._();

  /// Global key used for navigation
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Initialize routing with the context
  Future<void> init() async {
    /// Validate the targeting route
    final intent = MethodChannelService.instance.intentData;
    if (!AppRoutes.routes.containsKey(intent.route)) return;

    /// Push the user to targeted route
    if (intent.route == AppRoutes.upcomingNotificationsScreen) {
      _pushDelayedRoute(AppRoutes.upcomingNotificationsScreen);
    } else if (intent.extraPackageName.isNotEmpty &&
        intent.route == AppRoutes.appDashboardScreen) {
      _pushDelayedRoute(
        AppRoutes.appDashboardScreen,
        arguments: AppDashboardParams(packageName: intent.extraPackageName),
      );
    }
  }

  void _pushDelayedRoute(
    String validRouteName, {
    Object? arguments,
  }) async {
    await Future.delayed(500.ms);
    if (!(navigatorKey.currentState?.mounted ?? false)) return;

    navigatorKey.currentState?.pushNamed(
      validRouteName,
      arguments: arguments,
    );
  }
}
