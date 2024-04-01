import 'package:flutter/material.dart';

class StatefulText extends StatelessWidget {
  const StatefulText(
    this.text, {
    super.key,
    this.isActive = true,
    this.activeColor,
    this.inactiveColor,
    this.fontWeight,
    this.height,
    this.maxLines,
    this.overflow,
    this.fontSize = 12,
  });

  final String text;
  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;
  final double fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        color: isActive
            ? activeColor
            : inactiveColor ?? Theme.of(context).disabledColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        overflow: overflow,
      ),
    );
  }
}
