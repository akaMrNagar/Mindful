/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

extension ExtDuration on Duration {
  /// Returns a [Duration] when adding [other] to
  /// [this] with precision up to second.
  Duration add(Duration other) => Duration(
        seconds: inSeconds + other.inSeconds,
      );

  /// Returns a [Duration] when subtracting [other] from
  /// [this] with precision up to second.
  Duration subtract(Duration other) => Duration(
        seconds: inSeconds - other.inSeconds,
      );

  /// Formats the duration into time like '5h 45m' or '54m'
  String toTimeShort() {
    return inMinutes >= 60
        ? inMinutes % 60 == 0
            ? "${inHours}h"
            : "${inHours}h ${inMinutes % 60}m"
        : "${inMinutes}m";
  }

  /// Formats the duration into time like '5 hours, 45 minutes'
  String toTimeFull({bool replaceCommaWithAnd = false}) {
    final hours = inHours;
    final minutes = inMinutes % 60;
    final seconds = inSeconds % 60;

    final buffer = StringBuffer();

    if (hours > 0) {
      buffer.write('$hours ${hours > 1 ? 'hours' : 'hour'}');
    }

    if (minutes > 0) {
      if (buffer.isNotEmpty) buffer.write(replaceCommaWithAnd ? ' and ' : ', ');
      buffer.write('$minutes ${minutes > 1 ? 'minutes' : 'minute'}');
    }

    if (buffer.isEmpty) {
      buffer.write('$seconds ${seconds > 1 ? 'seconds' : 'second'}');
    }

    return buffer.toString();
  }
}
