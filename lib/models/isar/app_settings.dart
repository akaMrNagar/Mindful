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

  const AppSettings({
    this.themeMode = ThemeMode.system,
  });
}
