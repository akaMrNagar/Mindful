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
import 'package:mindful/ui/transitions/default_page_transition_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      ).copyWith(
        pageTransitionsTheme: _kPageTransitionTheme,
        extensions: [
          SkeletonizerConfigData.dark(
              effect: ShimmerEffect(
            highlightColor: Colors.white.withOpacity(0.3),
            baseColor: (materialColors[seedColor] ?? _kSeedColor)
                .shade50
                .withOpacity(0.1),
          )),
        ],
      );

  static ThemeData darkAmoledTheme(String seedColor) => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: materialColors[seedColor] ?? _kSeedColor,
          surface: Colors.black,
        ),
      ).copyWith(
        pageTransitionsTheme: _kPageTransitionTheme,
        scaffoldBackgroundColor: Colors.black,
        extensions: [
          SkeletonizerConfigData.dark(
              effect: ShimmerEffect(
            highlightColor: Colors.white.withOpacity(0.3),
            baseColor: (materialColors[seedColor] ?? _kSeedColor)
                .shade50
                .withOpacity(0.1),
          )),
        ],
      );

  static ThemeData lightTheme(String seedColor) => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: materialColors[seedColor] ?? _kSeedColor,
          brightness: Brightness.light,
        ),
      ).copyWith(
        pageTransitionsTheme: _kPageTransitionTheme,
        extensions: [
          SkeletonizerConfigData(
            effect: ShimmerEffect(
              highlightColor: Colors.black.withOpacity(0.3),
              baseColor: (materialColors[seedColor] ?? _kSeedColor)
                  .shade900
                  .withOpacity(0.1),
            ),
          ),
        ],
      );
}
