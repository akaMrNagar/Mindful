import 'package:flutter/material.dart';

class SegmentedIconButton extends StatelessWidget {
  const SegmentedIconButton({
    super.key,
    required this.selected,
    required this.segments,
    required this.onChange,
    this.borderRadius = 18,
    this.alignment = MainAxisAlignment.start,
  });

  final int selected;
  final List<IconData> segments;
  final Function(int index) onChange;
  final double borderRadius;
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

          return Container(
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).cardColor : null,
              borderRadius: borderRadiusG,
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).dividerColor
                    : Theme.of(context).focusColor,
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: InkWell(
              onTap: () => onChange(index),
              borderRadius: borderRadiusG,
              splashFactory: InkSparkle.splashFactory,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Icon(
                  segments[index],
                  color: isSelected ? null : Theme.of(context).dividerColor,
                  size: 20,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
