import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension ExtNum on TimeOfDay {
  /// Converts the time from hour and minutes to minutes only
  int toMinutes() => (hour * 60) + minute;

  /// Returns the difference in Duration
  /// i.e, DURATION = END.difference(START)
  Duration difference(TimeOfDay other) {
    int end = toMinutes();
    int start = other.toMinutes();

    return ((end < start) ? ((24 * 60) - start) + end : end - start).minutes;
  }
}
