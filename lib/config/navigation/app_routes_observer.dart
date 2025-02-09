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

class AppRoutesObserver extends NavigatorObserver {
  /// Private constructor to enforce singleton pattern.
  AppRoutesObserver._internal();

  /// Singleton instance of the [AppRoutesObserver].
  static final AppRoutesObserver instance = AppRoutesObserver._internal();

  String _currentRoute = "";

  /// The current route of the app or empty string
  String get currentRoute => _currentRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _currentRoute = route.settings.name ?? "";
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _currentRoute = newRoute?.settings.name ?? "";
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _currentRoute = previousRoute?.settings.name ?? "";
    super.didPop(route, previousRoute);
  }
}
