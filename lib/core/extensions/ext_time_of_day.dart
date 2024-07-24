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
