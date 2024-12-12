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

/// Represents an Android application with detailed information and usage statistics.
@immutable
class AndroidApp {
  /// The application's name or label displayed to the user.
  final String name;

  /// The unique package identifier used by the Android system to identify the app.
  final String packageName;

  /// Indicates whether the app belongs to the system's default category (e.g., Home Launcher, Dialer) or
  /// includes manually added apps like Tethering and Removed Apps.
  final bool isImpSysApp;

  /// A list containing the total screen time usage for the app in SECONDS for each day of the current week (7 entries).
  final List<int> screenTimeThisWeek;

  /// A list containing the total mobile data usage for the app in KILOBYTES for each day of the current week (7 entries).
  final List<int> mobileUsageThisWeek;

  /// A list containing the total Wi-Fi data usage for the app in KILOBYTES for each day of the current week (7 entries).
  final List<int> wifiUsageThisWeek;

  /// A list containing the combined total data usage (mobile + Wi-Fi) for the app in KILOBYTES for each day of the current week (7 entries).
  final List<int> networkUsageThisWeek;

  /// The application icon as a byte array provided by the Android system.
  final Uint8List icon;

  /// Number of launches for the current day
  final int launchCount;

  const AndroidApp({
    required this.name,
    required this.packageName,
    required this.icon,
    required this.launchCount,
    required this.isImpSysApp,
    required this.screenTimeThisWeek,
    required this.mobileUsageThisWeek,
    required this.wifiUsageThisWeek,
    required this.networkUsageThisWeek,
  });

  /// Creates an `AndroidApp` instance from a JSON-like map representation.
  factory AndroidApp.fromMap(Map<dynamic, dynamic> map) {
    return AndroidApp(
      name: map['appName'] as String,
      packageName: map['packageName'] as String,
      icon: base64Decode(map['appIcon'] as String),
      isImpSysApp: map['isImpSysApp'] as bool,
      launchCount: map['launchCount'] as int,
      screenTimeThisWeek:
          List<int>.from(map['screenTimeThisWeek'], growable: false),
      mobileUsageThisWeek:
          List<int>.from(map['mobileUsageThisWeek'], growable: false),
      wifiUsageThisWeek:
          List<int>.from(map['wifiUsageThisWeek'], growable: false),
      networkUsageThisWeek:
          List<int>.from(map['dataUsageThisWeek'], growable: false),
    );
  }

  AndroidApp copyWith({
    String? name,
    String? packageName,
    bool? isImpSysApp,
    List<int>? screenTimeThisWeek,
    List<int>? mobileUsageThisWeek,
    List<int>? wifiUsageThisWeek,
    List<int>? networkUsageThisWeek,
    Uint8List? icon,
    int? launchCount,
  }) {
    return AndroidApp(
      name: name ?? this.name,
      packageName: packageName ?? this.packageName,
      isImpSysApp: isImpSysApp ?? this.isImpSysApp,
      screenTimeThisWeek: screenTimeThisWeek ?? this.screenTimeThisWeek,
      mobileUsageThisWeek: mobileUsageThisWeek ?? this.mobileUsageThisWeek,
      wifiUsageThisWeek: wifiUsageThisWeek ?? this.wifiUsageThisWeek,
      networkUsageThisWeek: networkUsageThisWeek ?? this.networkUsageThisWeek,
      icon: icon ?? this.icon,
      launchCount: launchCount ?? this.launchCount,
    );
  }

  @override
  String toString() {
    return 'AndroidApp(name: $name, packageName: $packageName, isImpSysApp: $isImpSysApp, screenTimeThisWeek: $screenTimeThisWeek, mobileUsageThisWeek: $mobileUsageThisWeek, wifiUsageThisWeek: $wifiUsageThisWeek, networkUsageThisWeek: $networkUsageThisWeek, icon: $icon, launchCount: $launchCount)';
  }
}
