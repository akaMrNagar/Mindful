import 'package:flutter/material.dart';

class InteractiveCard extends StatelessWidget {
  const InteractiveCard({
    super.key,
    required this.child,
    this.onPressed,
    this.elevation = 0,
    this.circularRadius = 12,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(12),
    this.applyBorder = false,
    this.borderWidth = 1,
    this.height,
    this.width,
  });

  final Widget child;
  final double elevation;
  final double circularRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool applyBorder;
  final double borderWidth;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final paddedChild = Padding(
      padding: padding,
      child: Align(alignment: Alignment.center, child: child),
    );

    return SizedBox(
      height: height,
      width: width,
      child: Card(
        elevation: elevation,
        color: applyBorder ? Colors.transparent : Theme.of(context).cardColor,
        surfaceTintColor: Colors.white,
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularRadius),
          side: applyBorder
              ? BorderSide(
                  color: Theme.of(context).focusColor,
                  width: borderWidth,
                  strokeAlign: BorderSide.strokeAlignInside,
                )
              : BorderSide.none,
        ),
        child: onPressed == null
            ? paddedChild
            : InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(circularRadius),
                splashFactory: InkSparkle.splashFactory,
                child: paddedChild,
              ),
      ),
    );
  }
}
