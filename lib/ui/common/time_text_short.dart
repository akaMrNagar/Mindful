import 'package:flutter/material.dart';

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
                    TextSpan(text: "H", style: alphaStyle),
                  ]

                /// If have both hours and minutes
                : [
                    TextSpan(
                      text: (timeDuration.inMinutes ~/ 60).toString(),
                      style: numericStyle,
                    ),
                    TextSpan(text: "H", style: alphaStyle),
                    TextSpan(
                      text: " ${timeDuration.inMinutes % 60}",
                      style: numericStyle,
                    ),
                    TextSpan(text: "M", style: alphaStyle),
                  ]

            /// Less than an hour
            : [
                TextSpan(
                  text: (timeDuration.inSeconds ~/ 60).toString(),
                  style: numericStyle,
                ),
                TextSpan(text: "M", style: alphaStyle),
              ],
      ),
    );
  }
}
