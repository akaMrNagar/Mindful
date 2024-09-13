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

extension ExtNum on TimeOfDay {
  /// Converts the [TimeOfDay] from hour and minutes to minutes only
  int get minutes => (hour * 60) + minute;

  /// Returns the difference in Duration
  /// i.e, DURATION = END.difference(START)
  Duration difference(TimeOfDay other) {
    int end = minutes;
    int start = other.minutes;

    return ((end < start) ? ((24 * 60) - start) + end : end - start).minutes;
  }
}
