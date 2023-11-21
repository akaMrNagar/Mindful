import 'package:flutter/material.dart';

class SegmentedIconButton extends StatelessWidget {
  const SegmentedIconButton(
      {super.key,
      required this.selected,
      required this.segments,
      required this.onChange,
      this.radius = 18,
      this.alignment = MainAxisAlignment.start});

  final int selected;
  final List<IconData> segments;
  final Function(int index) onChange;
  final double radius;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: List.generate(
        segments.length,
        (index) {
          final isSelected = index == selected;
          final borderRadius = BorderRadius.horizontal(
            left: Radius.circular(index == 0 ? radius : 0),
            right: Radius.circular(index == (segments.length - 1) ? radius : 0),
          );

          return Card(
            elevation: 0,
            color:
                isSelected ? Theme.of(context).cardColor : Colors.transparent,
            surfaceTintColor: Colors.white,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: BorderSide(
                color: isSelected
                    ? Theme.of(context).highlightColor
                    : Theme.of(context).focusColor,
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: InkWell(
              onTap: () => onChange(index),
              borderRadius: borderRadius,
              splashFactory: InkSparkle.splashFactory,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Icon(
                  segments[index],
                  color: isSelected ? null : Theme.of(context).focusColor,
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
