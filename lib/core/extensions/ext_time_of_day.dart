import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension ExtNum on TimeOfDay {
  /// Converts the time from hour and minutes to seconds only
  int toSeconds() => ((hour * 60) + minute) * 60;

  /// Returns the difference in Duration
  /// i.e, DURATION = END.difference(START)
  Duration difference(TimeOfDay other) {
    int end = toSeconds();
    int start = other.toSeconds();

    return ((end < start) ? ((24 * 60 * 60) - start) + end : end - start)
        .seconds;
  }
}
