import 'package:flutter/material.dart';

// Offset from offscreen to the right to fully on screen.
final Animatable<Offset> _kRightMiddleTween = Tween<Offset>(
  begin: const Offset(1.0, 0.0),
  end: Offset.zero,
);

// Offset from fully on screen to 1/3 offscreen to the left.
final Animatable<Offset> _kMiddleLeftTween = Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(-1.0 / 3.0, 0.0),
);

class MindfulTransitionsBuilder extends PageTransitionsBuilder {
  /// Slide page transition like ios for android without any ios dependencies
  const MindfulTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final TextDirection textDirection = Directionality.of(context);

    return SlideTransition(
      position: CurvedAnimation(
        parent: animation,
        curve: Curves.fastEaseInToSlowEaseOut,
        reverseCurve: Curves.fastEaseInToSlowEaseOut.flipped,
      ).drive(_kRightMiddleTween),
      textDirection: textDirection,
      transformHitTests: false,
      child: SlideTransition(
        position: CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.linearToEaseOut,
          reverseCurve: Curves.easeInToLinear,
        ).drive(_kMiddleLeftTween),
        textDirection: textDirection,
        child: child,
      ),
    );
  }
}
