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
import 'package:mindful/core/extensions/ext_build_context.dart';

class TimeTextShort extends StatelessWidget {
  /// Rich text widget for displaying [Duration] in hours and minutes
  const TimeTextShort({
    super.key,
    required this.timeDuration,
    this.fontSize = 16,
    this.fontWeight,
    this.secondaryFontWeight,
    this.color,
  });

  final Duration timeDuration;
  final double fontSize;
  final FontWeight? fontWeight;
  final FontWeight? secondaryFontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final numericStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1,
    );

    final alphaStyle = TextStyle(
      fontSize: fontSize / 2,
      fontWeight: secondaryFontWeight,
      height: 1,
    );

    final hourShort = context.locale.hour_short.toUpperCase();
    final minuteShort = context.locale.minute_short.toUpperCase();

    return Text.rich(
      TextSpan(
        /// Greater than or equal to an hour
        children: timeDuration.inMinutes >= 60
            ?

            /// If exactly any hours but no minutes
            timeDuration.inMinutes % 60 == 0
                ? [
                    TextSpan(
                      text: (timeDuration.inMinutes ~/ 60).toString(),
                      style: numericStyle,
                    ),
                    TextSpan(text: hourShort, style: alphaStyle),
                  ]

                /// If have both hours and minutes
                : [
                    TextSpan(
                      text: (timeDuration.inMinutes ~/ 60).toString(),
                      style: numericStyle,
                    ),
                    TextSpan(text: hourShort, style: alphaStyle),
                    TextSpan(
                      text: " ${timeDuration.inMinutes % 60}",
                      style: numericStyle,
                    ),
                    TextSpan(text: minuteShort, style: alphaStyle),
                  ]

            /// Less than an hour
            : [
                TextSpan(
                  text: (timeDuration.inSeconds ~/ 60).toString(),
                  style: numericStyle,
                ),
                TextSpan(text: minuteShort, style: alphaStyle),
              ],
      ),
    );
  }
}
