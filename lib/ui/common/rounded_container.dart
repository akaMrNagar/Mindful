import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.height,
    this.width,
    this.color,
    this.borderColor,
    this.child,
    this.borderRadius,
    this.onPressed,
    this.elevation = 0,
    this.applyBorder = false,
    this.circularRadius = 18,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
  });

  final double? height;
  final double? width;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final bool applyBorder;
  final double elevation;
  final double circularRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? Theme.of(context).colorScheme.secondaryContainer;
    final radius = borderRadius ?? BorderRadius.circular(circularRadius);
    final borderSide = applyBorder
        ? BorderSide(
            color:
                borderColor ?? Theme.of(context).colorScheme.secondaryContainer,
            strokeAlign: BorderSide.strokeAlignInside,
          )
        : BorderSide.none;

    return onPressed == null

        /// Static container
        ? Container(
            width: width,
            height: height,
            margin: margin,
            padding: padding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: radius,
              border: Border.fromBorderSide(borderSide),
            ),
            child: child,
          )

        /// Interactive container
        : Container(
            height: height,
            width: width,
            margin: margin,
            child: Material(
              color: bgColor,
              elevation: elevation,
              shape: RoundedRectangleBorder(
                borderRadius: radius,
                side: borderSide,
              ),
              child: InkWell(
                onTap: onPressed,
                splashFactory: InkSparkle.splashFactory,
                splashColor: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: radius,
                child: Padding(
                  /// Added 1px to padding only because the border is 1px and
                  /// it is stroked inside
                  padding: applyBorder
                      ? padding.add(const EdgeInsets.all(1))
                      : padding,
                  child: Center(child: child),
                ),
              ),
            ),
          );
  }
}
