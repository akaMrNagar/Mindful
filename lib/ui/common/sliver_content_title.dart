import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverContentTitle extends StatelessWidget {
  /// Global title text with primary accent mainly used as a header for different sections in a list of widgets
  const SliverContentTitle({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.only(top: 12, bottom: 4),
    this.alignment = Alignment.centerLeft,
  });

  final String title;
  final EdgeInsets padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: alignment,
      child: StyledText(
        title,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    ).sliver;
  }
}
