import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.circularRadius = 12,
    this.borderRadius,
    this.height,
    this.width,
    this.margin,
  });

  final Widget child;
  final double circularRadius;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(circularRadius),
          )),
          backgroundColor: const MaterialStatePropertyAll(Color(0xFF0EABE1)),
        ),
        child: child,
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.circularRadius = 12,
    this.borderRadius,
    this.height,
    this.width,
    this.margin,
  });

  final Widget child;
  final double circularRadius;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(circularRadius),
          )),
          backgroundColor:
              MaterialStatePropertyAll(Theme.of(context).cardColor),
        ),
        child: child,
      ),
    );
  }
}

class TertiaryButton extends StatelessWidget {
  const TertiaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.circularRadius = 12,
    this.borderRadius,
    this.height,
    this.width,
    this.margin,
  });

  final Widget child;
  final double circularRadius;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).focusColor,
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(circularRadius),
          )),
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
        ),
        child: child,
      ),
    );
  }
}
