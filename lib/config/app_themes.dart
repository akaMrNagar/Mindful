import 'package:flutter/material.dart';
import 'package:mindful/config/mindful_transiton_builder.dart';

class AppTheme {
  static const _kSeedColor = Colors.lightBlue;

  /// Custom transition for page routes
  static const _kPageTransitionTheme = PageTransitionsTheme(
    builders: {TargetPlatform.android: MindfulTransitionsBuilder()},
  );

  static final darkTheme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _kSeedColor,
      brightness: Brightness.dark,
    ),
  ).copyWith(pageTransitionsTheme: _kPageTransitionTheme);

  static final lightTheme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _kSeedColor,
      brightness: Brightness.light,
    ),
  ).copyWith(pageTransitionsTheme: _kPageTransitionTheme);
}
