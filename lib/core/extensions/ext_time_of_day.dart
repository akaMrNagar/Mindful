import 'package:flutter/material.dart';

extension ExtNum on TimeOfDay {
  /// Converts the time from hour and minutes to minutes only
  int toMinutes() => (hour * 60) + minute;

  /// Returns the difference in minutes (this - b)
  int difference(TimeOfDay s) {
    int end = toMinutes();
    int start = s.toMinutes();
    int dur = 0;

    if (period.index == s.period.index) {
      return toMinutes() - s.toMinutes();
    } else if (period.index == 0 && s.period.index == 1) {
      return toMinutes() + s.toMinutes();
    } else if (period.index == 1 && s.period.index == 0) {
      return toMinutes() - s.toMinutes();
    }

    if (start > end) {
      dur = (24 * 60) - start + end;
    } else {
      dur = end - start;
    }

    return dur;
  }
}
