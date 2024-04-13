import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'settings_model.g.dart';

/// All the global settings for the app is stored in this model
/// like [themeMode],
@immutable
@collection
class SettingsModel {
  /// ID for isar database
  Id get id => 0;

  /// Default theme mode for app
  @enumerated
  final ThemeMode themeMode;

  const SettingsModel({
    this.themeMode = ThemeMode.system,
  });
}
