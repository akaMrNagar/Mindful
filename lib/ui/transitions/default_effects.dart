/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

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
