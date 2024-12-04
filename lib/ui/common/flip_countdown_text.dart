/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class FlipCountdownText extends StatelessWidget {
  const FlipCountdownText({
    super.key,
    required this.duration,
    this.alwaysShowMinutes = true,
  });

  final Duration duration;
  final bool alwaysShowMinutes;

  @override
  Widget build(BuildContext context) {
    final hoursTick = duration.inHours;
    final minutesTick = duration.inMinutes % 60;
    final secondsTick = duration.inSeconds % 60;

    const timeStyle = TextStyle(fontSize: 48, fontWeight: FontWeight.w600);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Hours
        if (hoursTick > 0)
          AnimatedFlipCounter(
            prefix: hoursTick < 10 ? "0" : null,
            value: hoursTick,
            suffix: ":",
            textStyle: timeStyle,
          ),

        /// Minutes
        if (alwaysShowMinutes)
          AnimatedFlipCounter(
            prefix: minutesTick < 10 ? "0" : null,
            value: minutesTick,
            suffix: ":",
            textStyle: timeStyle,
          ),

        /// Seconds
        AnimatedFlipCounter(
          prefix: secondsTick < 10 ? "0" : null,
          value: secondsTick,
          textStyle: timeStyle,
        ),
      ],
    );
  }
}
