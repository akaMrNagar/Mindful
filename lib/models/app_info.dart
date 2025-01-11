/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Represents an Android application with its info.
@immutable
class AppInfo {
  /// The application's name or label displayed to the user.
  final String name;

  /// The unique package identifier used by the Android system to identify the app.
  final String packageName;

  /// Indicates whether the app belongs to the system's default category (e.g., Home Launcher, Dialer) or
  /// includes manually added apps like Tethering and Removed Apps.
  final bool isImpSysApp;

  /// The application icon as a byte array provided by the Android system.
  final Uint8List icon;

  const AppInfo({
    required this.name,
    required this.packageName,
    required this.isImpSysApp,
    required this.icon,
  });

  /// Creates an `AndroidApp` instance from a JSON-like map representation.
  factory AppInfo.fromMap(Map<dynamic, dynamic> map) {
    return AppInfo(
      name: map['appName'] as String,
      packageName: map['packageName'] as String,
      icon: base64Decode(map['appIcon'] as String),
      isImpSysApp: map['isImpSysApp'] as bool,
    );
  }

  factory AppInfo.placeHolder(String packageName) {
    return AppInfo(
      name: "",
      packageName: packageName,
      icon: Uint8List(0),
      isImpSysApp: true,
    );
  }

  @override
  String toString() {
    return 'AppInfo(name: $name, packageName: $packageName, isImpSysApp: $isImpSysApp)';
  }

  @override
  bool operator ==(Object other) {
    return other is AppInfo && other.packageName == packageName;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        packageName.hashCode ^
        isImpSysApp.hashCode ^
        icon.hashCode;
  }
}
