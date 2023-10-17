/// Global widgets for displaying different text in the app
/// Defined here for better controling and customization.
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(this.text, {super.key, this.size, this.weight});

  final String text;
  final double? size;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 16,
        fontWeight: weight ?? FontWeight.w600,
        overflow: TextOverflow.fade,
      ),
    );
  }
}

class SubtitleText extends StatelessWidget {
  const SubtitleText(this.text, {super.key, this.size, this.weight});

  final String text;
  final double? size;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 12,
        fontWeight: weight,
        overflow: TextOverflow.fade,
        color: Theme.of(context).hintColor,
      ),
    );
  }
}
