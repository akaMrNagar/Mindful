/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:mindful/core/extensions/ext_date_time.dart';

extension ExtInt on int {
  /// Converts KB to MB
  int get mb => this ~/ 1024;

  /// Converts KB to GB
  double get gb => this / 1048576;

  /// Converts Seconds to Minutes
  int get inMinutes => this ~/ 60;

  /// Converts Seconds to Hours
  double get inHours => this / 3600;

  /// Generates data usage string from data in KBs like 356 KB, 456 MB, 2.56 GB
  String toData() {
    if (toInt() < 1024) {
      return "${toInt()} KB";
    } else if (toInt().mb >= 1024) {
      return "${toInt().gb.toStringAsFixed(2)} GB";
    } else {
      return "${toInt().mb} MB";
    }
  }

  /// Generates progress/downfall percentage from current value and previous value
  int toDiffPercentage(int previous) {
    return previous > 0 ? ((this - previous) / previous * 100).round() : 0;
  }

  /// Returns [DateTime] object by creating it through fromMillisecondsSinceEpoch() constructor
  DateTime get msToDateTime => DateTime.fromMillisecondsSinceEpoch(this);

  /// Returns [DateTime] object while resetting time related fields by creating it through fromMillisecondsSinceEpoch() constructor
  DateTime get msToDateOnly =>
      DateTime.fromMillisecondsSinceEpoch(this).dateOnly;
}
