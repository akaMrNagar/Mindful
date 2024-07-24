import 'package:flutter/material.dart';
import 'package:mindful/ui/common/rounded_container.dart';

class SegmentedIconButtons extends StatelessWidget {
  /// Alternative to native [SegmentedButton] but only for icons
  const SegmentedIconButtons({
    super.key,
    required this.selected,
    required this.segments,
    required this.onChange,
    this.borderRadius = 14,
    this.height = 40,
    this.alignment = MainAxisAlignment.start,
  });

  final int selected;
  final List<IconData> segments;
  final Function(int index) onChange;
  final double borderRadius;
  final double height;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: List.generate(
        segments.length,
        (index) {
          final isSelected = index == selected;
          final borderRadiusG = BorderRadius.horizontal(
            left: Radius.circular(index == 0 ? borderRadius : 0),
            right: Radius.circular(
                index == (segments.length - 1) ? borderRadius : 0),
          );

          return RoundedContainer(
            height: height,
            color: isSelected ? null : Colors.transparent,
            borderColor: isSelected ? Colors.transparent : null,
            applyBorder: !isSelected,
            borderRadius: borderRadiusG,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            onPressed: () => onChange(index),
            child: Icon(
              segments[index],
              color: isSelected ? null : Theme.of(context).disabledColor,
              size: 20,
            ),
          );
        },
      ),
    );
  }
}
