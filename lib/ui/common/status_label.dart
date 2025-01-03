import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class StatusLabel extends StatelessWidget {
  const StatusLabel({
    super.key,
    required this.label,
    this.accent,
  });

  final String label;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final accentColor = accent ?? Theme.of(context).colorScheme.primary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundedContainer(
          circularRadius: 8,
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          color: accentColor.withOpacity(0.15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedContainer(
                height: 10,
                width: 10,
                color: accentColor,
              ),
              8.hBox,
              StyledText(
                label,
                fontWeight: FontWeight.w500,
                color: accentColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
