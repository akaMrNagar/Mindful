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
