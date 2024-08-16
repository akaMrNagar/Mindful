import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mindful/core/enums/usage_algorithm.dart';
import 'package:mindful/core/extensions/ext_int.dart';

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

  /// Default usage algorithm  for app
  @enumerated
  final UsageAlgorithm algorithm;

  /// Default material color for app
  final String color;

  /// Is invincible mode on if it is ON then user cannot change following :
  ///
  /// 1. App timer if it is purged
  /// 2. Bedtime settings between the scheduled duration
  final bool isInvincibleModeOn;

  /// Daily data usage renew or reset time [TimeOfDay] stored as minutes
  final int dataResetTimeMins;

  /// Getter for daily data usage renew and reset time
  @ignore
  TimeOfDay get dataResetToD => dataResetTimeMins.toTimeOfDay;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.algorithm = UsageAlgorithm.usageEvents,
    this.color = 'Indigo',
    this.isInvincibleModeOn = false,
    this.dataResetTimeMins = 0, // 12:00 AM
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    UsageAlgorithm? algorithm,
    String? color,
    bool? isInvincibleModeOn,
    int? dataResetTimeMins,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      algorithm: algorithm ?? this.algorithm,
      color: color ?? this.color,
      isInvincibleModeOn: isInvincibleModeOn ?? this.isInvincibleModeOn,
      dataResetTimeMins: dataResetTimeMins ?? this.dataResetTimeMins,
    );
  }
}
