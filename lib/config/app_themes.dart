import 'package:flutter/material.dart';
import 'package:mindful/ui/transitions/default_page_transition_builder.dart';

class AppTheme {
  static const _kSeedColor = Colors.lightBlue;

  /// Custom transition for page routes
  static const _kPageTransitionTheme = PageTransitionsTheme(
    builders: {TargetPlatform.android: DefaultPageTransitionsBuilder()},
  );

  static final materialColors = <String, MaterialColor>{
    'Amber': Colors.amber,
    'Blue': Colors.blue,
    'Blue Grey': Colors.blueGrey,
    'Brown': Colors.brown,
    'Cyan': Colors.cyan,
    'Deep Orange': Colors.deepOrange,
    'Deep Purple': Colors.deepPurple,
    'Green': Colors.green,
    'Grey': Colors.grey,
    'Indigo': Colors.indigo,
    'Light Blue': Colors.lightBlue,
    'Light Green': Colors.lightGreen,
    'Lime': Colors.lime,
    'Orange': Colors.orange,
    'Pink': Colors.pink,
    'Purple': Colors.purple,
    'Red': Colors.red,
    'Teal': Colors.teal,
    'Yellow': Colors.yellow,
  };

  static ThemeData darkTheme(String seedColor) => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: materialColors[seedColor] ?? _kSeedColor,
          brightness: Brightness.dark,
        ),
      ).copyWith(pageTransitionsTheme: _kPageTransitionTheme);

  static ThemeData lightTheme(String seedColor) => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: materialColors[seedColor] ?? _kSeedColor,
          brightness: Brightness.light,
        ),
      ).copyWith(pageTransitionsTheme: _kPageTransitionTheme);
}
