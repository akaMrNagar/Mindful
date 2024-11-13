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
import 'package:intl/intl.dart';

extension ExtDateTime on DateTime {
  /// Returns the object with date only while resetting all time related field to 0
  DateTime get dateOnly => copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );

  /// Returns date-only for the starting of the month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Returns date-only for the end of the month
  DateTime get endOfMonth => DateTime(year, month + 1, 1).subtract(1.days);

  /// Returns the total number of day in the [DateTime]'s month
  int get daysInMonth => endOfMonth.difference(startOfMonth).inDays + 1;

  /// Returns date-only string in a localized format (e.g., 15 August, 2024).
  String dateString(BuildContext context) =>
      DateFormat.yMMMMd(Localizations.localeOf(context).languageCode)
          .format(this);

  /// Returns time-only string in a localized format (e.g., 7:15 PM).
  String timeString(BuildContext context) =>
      DateFormat.jm(Localizations.localeOf(context).languageCode).format(this);
}
