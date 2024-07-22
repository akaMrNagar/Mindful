import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DefaultEffects {
  static List<Effect> get transitionIn => [
        MoveEffect(
          duration: 750.ms,
          curve: Curves.decelerate,
          begin: const Offset(0, 100),
          end: Offset.zero,
        ),
        ScaleEffect(
          duration: 750.ms,
          curve: Curves.decelerate,
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
        ),
        FadeEffect(
          duration: 1000.ms,
          curve: Curves.decelerate,
          begin: 0,
          end: 1,
        ),
      ];

  static List<Effect> shimmer(Color color) => [
        ShimmerEffect(
          curve: Curves.easeOut,
          duration: 1000.ms,
          padding: 0,
          color: color,
        )
      ];
}
