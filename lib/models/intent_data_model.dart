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

@immutable
class IntentDataModel {
  /// Route name passed through Intent when starting the app.
  ///
  /// User will be forwarded to this route's screen
  final String route;

  /// Flag indicating if the app is restarted by itself (after importing database).
  final bool extraIsSelfStart;

  /// Package name of the app whose overlay dialog's emergency button is clicked.
  ///
  /// This is forwarded by the overlay dialog service to open app dashboard.
  final String extraPackageName;

  const IntentDataModel({
    this.route = "",
    this.extraIsSelfStart = false,
    this.extraPackageName = "",
  });

  factory IntentDataModel.fromMap(Map<dynamic, dynamic> map) {
    return IntentDataModel(
      route: map['route'] ?? '',
      extraIsSelfStart: map['extraIsSelfStart'] ?? false,
      extraPackageName: map['extraPackageName'] ?? '',
    );
  }

  @override
  String toString() =>
      'IntentData(route: $route, extraIsSelfStart: $extraIsSelfStart, extraPackageName: $extraPackageName)';
}
