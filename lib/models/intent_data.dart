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
class IntentData {
  /// Flag indicating if the app is restarted by itself (after importing database).
  final bool isSelfRestart;

  /// Route name passed through Intent when starting the app
  final String route;

  /// Package name of the app whose Time Limit Exceeded dialog's emergency button is clicked.
  /// This is forwarded by the overlay dialog service to show the emergency button on the dashboard.
  final String targetedPackage;

  const IntentData({
    this.isSelfRestart = false,
    this.route = '',
    this.targetedPackage = '',
  });

  factory IntentData.fromMap(Map<dynamic, dynamic> map) {
    return IntentData(
      isSelfRestart: map['isSelfRestart'] ?? false,
      route: map['route'] ?? '',
      targetedPackage: map['targetedPackage'] ?? '',
    );
  }
}
