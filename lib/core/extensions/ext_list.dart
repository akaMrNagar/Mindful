/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension ExtWidgetList on List<Widget> {
  /// Equivalent to [AnimateSliverList] but with target for animation
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
