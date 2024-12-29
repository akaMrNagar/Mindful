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

  /// Initialize routing with the context
  Future<void> init(BuildContext context) async {
    final intentData = MethodChannelService.instance.intentData;

    /// Check and push user to upcoming notifications screen
    if (intentData.route == AppRoutes.upcomingNotificationsScreen) {
      _openDelayedRoute(context, AppRoutes.upcomingNotificationsScreen);
    }
  }

  void _openDelayedRoute(BuildContext context, String validRouteName) async {
    await Future.delayed(1500.ms);
    if (!context.mounted) return;
    Navigator.of(context).pushNamed(validRouteName);
  }
}
