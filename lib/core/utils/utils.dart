/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

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
