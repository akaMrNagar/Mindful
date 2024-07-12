import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'app_settings.g.dart';

/// All the global settings for the app is stored in this model
/// like [themeMode],
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

  /// Flag denoting if to use system fonts or default app fonts
  final bool useSystemFont;

  /// Is invincible mode on if it is ON then user cannot change following :
  /// 1. App timer if it is purged
  /// 2. Bedtime settings between the scheduled duration
  final bool isInvincibleModeOn;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.isInvincibleModeOn = true,
    this.color = 'Light Blue',
    this.useSystemFont = false,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? color,
    bool? useSystemFont,
    bool? isInvincibleModeOn,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      color: color ?? this.color,
      useSystemFont: useSystemFont ?? this.useSystemFont,
      isInvincibleModeOn: isInvincibleModeOn ?? this.isInvincibleModeOn,
    );
  }
}
