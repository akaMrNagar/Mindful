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
    this.applyBorder = false,
    this.circularRadius = 12,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
  });

  final double? height;
  final double? width;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final bool applyBorder;
  final double circularRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: onPressed == null ? padding : null,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(circularRadius),
        border: applyBorder
            ? Border.all(
                color: borderColor ?? Theme.of(context).focusColor,
                strokeAlign: BorderSide.strokeAlignInside,
              )
            : null,
      ),
      child: onPressed == null
          ? child
          : InkWell(
              onTap: onPressed,
              borderRadius:
                  borderRadius ?? BorderRadius.circular(circularRadius),
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
    );
  }
}
