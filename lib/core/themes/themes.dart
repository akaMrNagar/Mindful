import 'package:flutter/material.dart';

class AppTheme {
  /// NOTE: To modify color of all text go to widgets/_common/cutom_text.dart and modify there
  ///       as all the text widgets in app are instance of these widgets

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme.dark(),
    splashFactory: InkSparkle.splashFactory,
    cardColor: const Color(0xFF1D2327),
    scaffoldBackgroundColor: const Color(0xFF12181C),
  );
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme.light(),
    splashFactory: InkSparkle.splashFactory,
    cardColor: const Color(0xFFD8DEE2),
    scaffoldBackgroundColor: const Color(0xFFE3E9ED),
  );

  //TODO: Generate diffrenet color schemes from realtime colors both dark and light and map background and secondary to scaffold bg and card bg
}
