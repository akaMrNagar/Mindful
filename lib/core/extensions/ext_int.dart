
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/core/utils/utils.dart';

extension ExtInt on int {
  int get mb => this ~/ 1024;
  double get gb => this / 1048576;
  int get inMinutes => this ~/ 60;
  double get inHours => this / 3600;

  String toDateDiffToday() {
    ///FIXME: bug in date
    if (toInt() == now.weekday) {
      return "Today";
    } else if (toInt() == now.weekday - 1) {
      return "Yesterday";
    } else {
      final dt = DateTime.fromMillisecondsSinceEpoch(
          now.millisecondsSinceEpoch -
              ((now.weekday - toInt()) * 24 * 60 * 60000));
      return "${AppStrings.daysFull[toInt()]}, ${dt.day} ${AppStrings.monthsShort[dt.month - 1]}";
    }
  }

  String toData() {
    if (toInt() == 0) {
      return "No data used";
    }
    if (toInt() < 1024) {
      return "${toInt()} KB";
    } else if (toInt().mb >= 1024) {
      return "${toInt().gb.toStringAsFixed(2)} GB";
    } else {
      return "${toInt().mb} MB";
    }
  }
}
