import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/core/utils/utils.dart';

extension ExtInt on int {
  /// Converts KB to MB
  int get mb => this ~/ 1024;

  /// Converts KB to GB
  double get gb => this / 1048576;

  /// Converts Seconds to Minutes
  int get inMinutes => this ~/ 60;

  /// Converts Seconds to Hours
  double get inHours => this / 3600;

  /// Converts minutes to [TimeOfDay]
  TimeOfDay get toTimeOfDay => TimeOfDay(hour: this ~/ 60, minute: this % 60);

  /// Generates day's date string based on the current day of week
  String dateFromDoW() {
    if (toInt() == todayOfWeek) {
      return "Today";
    } else if (toInt() == todayOfWeek - 1) {
      return "Yesterday";
    } else {
      final dt = toInt() < todayOfWeek
          ? now.subtract(Duration(days: toInt() + todayOfWeek))
          : now.add(Duration(days: toInt() - todayOfWeek));
      return "${AppStrings.daysFull[toInt()]}, ${dt.day} ${AppStrings.monthsLabelShort[dt.month - 1]}";
    }
  }

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
