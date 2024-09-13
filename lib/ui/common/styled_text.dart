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

class StyledText extends StatelessWidget {
  /// Globally used text widget with provided configurations.
  ///
  /// Shades the text color to disabled color if [isSubtitle] is set to TRUE
  const StyledText(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.height,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.letterSpacing,
    this.isSubtitle = false,
    this.fontSize = 12,
  });

  final String text;
  final bool isSubtitle;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? letterSpacing;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      // semanticsLabel: text,
      style: TextStyle(
        color: color ?? (isSubtitle ? Theme.of(context).disabledColor : null),
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        overflow: overflow,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
