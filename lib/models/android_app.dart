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
import 'package:mindful/core/enums/application_category.dart';

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

  /// The application category as defined within its manifest file used by the Android system.
  final AppCategory category;

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
    required this.category,
    required this.screenTimeThisWeek,
    required this.mobileUsageThisWeek,
    required this.wifiUsageThisWeek,
    required this.networkUsageThisWeek,
  });

  /// Creates an `AndroidApp` instance from a JSON-like map representation.
  factory AndroidApp.fromMap(Map<dynamic, dynamic> map) {
    return AndroidApp(
      launchCount: 0,
      name: map['appName'] as String,
      packageName: map['packageName'] as String,
      icon: base64Decode(map['appIcon'] as String),
      isImpSysApp: map['isImpSysApp'] as bool,
      category: _parseCategory(map['category'] as int),
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

  /// Parses an integer representing an app category index into an `AppCategory` enum value.
  static AppCategory _parseCategory(int index) {
    return switch (index) {
      -1 => AppCategory.undefined,
      0 => AppCategory.game,
      1 => AppCategory.audio,
      2 => AppCategory.video,
      3 => AppCategory.image,
      4 => AppCategory.social,
      5 => AppCategory.news,
      6 => AppCategory.maps,
      7 => AppCategory.productivity,
      8 => AppCategory.accessibility,
      _ => AppCategory.undefined,
    };
  }

  AndroidApp copyWith({
    String? name,
    String? packageName,
    bool? isImpSysApp,
    Uint8List? icon,
    AppCategory? category,
    List<int>? screenTimeThisWeek,
    List<int>? mobileUsageThisWeek,
    List<int>? wifiUsageThisWeek,
    List<int>? networkUsageThisWeek,
    int? launchCount,
  }) {
    return AndroidApp(
      name: name ?? this.name,
      packageName: packageName ?? this.packageName,
      isImpSysApp: isImpSysApp ?? this.isImpSysApp,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      screenTimeThisWeek: screenTimeThisWeek ?? this.screenTimeThisWeek,
      mobileUsageThisWeek: mobileUsageThisWeek ?? this.mobileUsageThisWeek,
      wifiUsageThisWeek: wifiUsageThisWeek ?? this.wifiUsageThisWeek,
      networkUsageThisWeek: networkUsageThisWeek ?? this.networkUsageThisWeek,
      launchCount: launchCount ?? this.launchCount,
    );
  }

  @override
  String toString() {
    return 'AndroidApp(name: $name, packageName: $packageName, isImpSysApp: $isImpSysApp, category: $category, screenTimeThisWeek: $screenTimeThisWeek, mobileUsageThisWeek: $mobileUsageThisWeek, wifiUsageThisWeek: $wifiUsageThisWeek, networkUsageThisWeek: $networkUsageThisWeek, icon: $icon, launchCount: $launchCount)';
  }
}
