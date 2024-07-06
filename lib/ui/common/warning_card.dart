import 'package:flutter/material.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({
    super.key,
    this.isVisible = true,
    required this.warning,
    required this.iconData,
    this.onPressed,
    this.buttonText,
  });

  final bool isVisible;
  final String warning;
  final IconData iconData;
  final VoidCallback? onPressed;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
