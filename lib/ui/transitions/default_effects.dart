import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DefaultEffects {
  static List<Effect> get transitionIn => [
        MoveEffect(
          duration: 600.ms,
          curve: Curves.fastEaseInToSlowEaseOut,
          begin: const Offset(0, 100),
          end: Offset.zero,
        ),
        ScaleEffect(
          duration: 600.ms,
          curve: Curves.decelerate,
          begin: const Offset(0.85, 0.85),
          end: const Offset(1, 1),
        ),
        FadeEffect(
          duration: 800.ms,
          curve: Curves.decelerate,
          begin: 0,
          end: 1,
        ),
      ];
}
