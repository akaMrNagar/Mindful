/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:mindful/core/utils/strings.dart';

extension ExtDateTime on DateTime {
  /// Returns the object with date only while resetting all time related field to 0
  DateTime get dateOnly => copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );

  /// Returns date only string like (15 August, 2024)
  String get dateString =>
      "$day ${AppStrings.monthsLabelFull[month - 1]}, $year";

  /// Returns time only string like (7:15 PM)
  String get timeString => "${hour % 12}:$minute ${hour > 12 ? 'PM' : 'AM'}";
}
