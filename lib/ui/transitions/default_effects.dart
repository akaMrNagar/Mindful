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
import 'package:mindful/core/utils/app_constants.dart';

class DefaultEffects {
  static List<Effect> get transitionIn => [
        MoveEffect(
          duration: AppConstants.defaultAnimDuration * 2,
          curve: AppConstants.defaultCurve,
          begin: const Offset(0, 100),
          end: Offset.zero,
        ),
        ScaleEffect(
          duration: AppConstants.defaultAnimDuration * 2,
          curve: AppConstants.defaultCurve,
          begin: const Offset(0.85, 0.85),
          end: const Offset(1, 1),
        ),
        FadeEffect(
          duration: AppConstants.defaultAnimDuration * 2.5,
          curve: AppConstants.defaultCurve,
          begin: 0,
          end: 1,
        ),
      ];
}
