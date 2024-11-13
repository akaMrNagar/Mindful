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
import 'package:mindful/core/enums/item_position.dart';

/// DateTime.now()
DateTime get now => DateTime.now();

/// Calculates the day index for today (0-based) within the current week,
/// adjusted to start on Sunday (like Java) instead of Monday (default in Dart).
int get todayOfWeek => _formatWeekDayToSunday(now.weekday) - 1;

/// Internal helper function to adjust the day of week index to start on Sunday
/// (like Java) instead of Monday (default in Dart).
///
/// This function takes the original `weekday` value (0-6) and maps it to
/// a new value considering Sunday as the first day (0).
int _formatWeekDayToSunday(int weekDay) {
  return switch (weekDay) {
    DateTime.monday => DateTime.tuesday,
    DateTime.tuesday => DateTime.wednesday,
    DateTime.wednesday => DateTime.thursday,
    DateTime.thursday => DateTime.friday,
    DateTime.friday => DateTime.saturday,
    DateTime.saturday => DateTime.sunday,
    DateTime.sunday => DateTime.monday,
    int() => 1,
  };
}

BorderRadius getBorderRadiusFromPosition(ItemPosition position) =>
    switch (position) {
      ItemPosition.start => const BorderRadius.vertical(
          top: Radius.circular(24),
          bottom: Radius.circular(6),
        ),
      ItemPosition.mid => BorderRadius.circular(6),
      ItemPosition.end => const BorderRadius.vertical(
          top: Radius.circular(6),
          bottom: Radius.circular(24),
        ),
      ItemPosition.none => BorderRadius.circular(24),
    };
