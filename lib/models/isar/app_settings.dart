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
import 'package:isar/isar.dart';


part 'app_settings.g.dart';

/// All the global settings for the app is stored in this model
/// like themeMode, material color, invincible mode and more,
@immutable
@collection
class AppSettings {
  /// ID for isar database
  Id get id => 0;

  /// Default theme mode for app
  @enumerated
  final ThemeMode themeMode;

  /// Default material color for app
  final String color;

  /// Username shown on the dashboard
  final String username;

  /// App Locale (Language code)
  final String localeCode;

  /// Is invincible mode on if it is ON then user cannot change following :
  ///
  /// 1. App timer if it is purged
  /// 2. Short content time if it is exhausted
  final bool isInvincibleModeOn;

  /// Daily data usage renew or reset time [TimeOfDay] stored as minutes
  final int dataResetTimeMins;

  /// Flag indicating if to use bottom navigation or the default sidebar
  final bool bottomNavigation;

  /// Flag indicating if to use pure black color for dark theme
  final bool amoledDark;

  const AppSettings({
    this.username = "Hustler",
    this.color = 'Indigo',
    this.localeCode = 'en',
    this.themeMode = ThemeMode.system,
    this.isInvincibleModeOn = false,
    this.dataResetTimeMins = 0, // 12:00 AM
    this.bottomNavigation = false,
    this.amoledDark = false,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? color,
    String? username,
    String? localeCode,
    bool? isInvincibleModeOn,
    int? dataResetTimeMins,
    bool? bottomNavigation,
    bool? amoledDark,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      color: color ?? this.color,
      username: username ?? this.username,
      localeCode: localeCode ?? this.localeCode,
      isInvincibleModeOn: isInvincibleModeOn ?? this.isInvincibleModeOn,
      dataResetTimeMins: dataResetTimeMins ?? this.dataResetTimeMins,
      bottomNavigation: bottomNavigation ?? this.bottomNavigation,
      amoledDark: amoledDark ?? this.amoledDark,
    );
  }
}
