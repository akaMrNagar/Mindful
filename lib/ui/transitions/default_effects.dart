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
import 'package:flutter_animate/flutter_animate.dart';

class DefaultEffects {
  static List<Effect> get transitionIn => [
        FadeEffect(
          duration: 1000.ms,
          curve: Curves.easeOutSine,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          duration: 750.ms,
          curve: Curves.easeOutBack,
          begin: const Offset(0, 100),
          end: Offset.zero,
        ),
        ScaleEffect(
          duration: 500.ms,
          curve: Curves.easeOutBack,
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
        ),
      ];
}
