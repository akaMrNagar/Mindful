import 'package:flutter/material.dart';

extension ExtNum on TimeOfDay {
  /// Converts the time from hour and minutes to minutes only
  int toMinutes() => (hour * 60) + minute;

  TimeOfDay fromMinutes(int mins) =>
      TimeOfDay(hour: mins ~/ 60, minute: mins % 60);

  /// Returns the difference in minutes (this - other)
  int difference(TimeOfDay other) {
    int end = toMinutes();
    int start = other.toMinutes();

    if (end < start) {
      return ((24 * 60) - start) + end;
    } else {
      return end - start;
    }
  }
}
