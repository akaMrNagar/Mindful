import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension ExtList on List<Widget> {
  /// Equivalent to [AnimateList] but with target for animation
  /// Animates list of widgets moving up, scaling and fading in based on the when condition
  /// other wise returns the original list of widgets
  List<Widget> animateListWhen({
    required bool when,
    AnimateCallback? onInit,
    AnimateCallback? onPlay,
    AnimateCallback? onComplete,
    bool? autoPlay,
    Duration? delay,
    Duration? interval,
    List<Effect>? effects,
  }) {
    return when
        ? animate(
            effects: effects,
            onInit: onInit,
            onPlay: onPlay,
            onComplete: onComplete,
            autoPlay: autoPlay,
            delay: delay,
            interval: interval,
          )
        : this;
  }
}
