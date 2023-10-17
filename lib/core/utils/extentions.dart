import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/core/utils/utils.dart';

extension ExtInt on int {
  int get mb => this ~/ 1024;
  double get gb => this / 1048576;
  int get inMinutes => this ~/ 60;
  double get inHours => this / 3600;

  String toDateDiffToday() {
    ///TODO: bug in date
    if (toInt() == now.weekday) {
      return "Today";
    } else if (toInt() == now.weekday - 1) {
      return "Yesterday";
    } else {
      final dt = DateTime.fromMillisecondsSinceEpoch(
          now.millisecondsSinceEpoch -
              ((now.weekday - toInt()) * 24 * 60 * 60000));
      return "${daysFull[toInt()]}, ${dt.day} ${monthsShort[dt.month - 1]}";
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

extension ExtDuration on Duration {
  String toTimeShort() {
    if (inMinutes >= 60) {
      if (inMinutes % 60 == 0) {
        return "${inMinutes ~/ 60}h";
      } else {
        return "${inMinutes ~/ 60}h ${inMinutes % 60}m";
      }
    } else {
      return "${inMinutes}m";
    }
  }

  String toTime() {
    if (inSeconds < 60) {
      return "$inSeconds ${inSeconds > 1 ? "secs" : "sec"}";
    }

    StringBuffer stringBuffer = StringBuffer();

    if (inHours > 0) {
      stringBuffer.write(inHours % 24);
      stringBuffer.write(inHours > 1 ? " hrs" : " hr");
    }

    if (inMinutes > 0 && inMinutes % 60 != 0) {
      if (inMinutes > 60) stringBuffer.write(", ");
      stringBuffer.write(inMinutes % 60);
      stringBuffer.write(inMinutes % 60 > 1 ? " mins" : " min");
    }

    return stringBuffer.toString();
  }

  String toTimeFull() {
    if (inSeconds < 60) {
      return "$inSeconds ${inSeconds > 1 ? "seconds" : "second"}";
    }

    StringBuffer stringBuffer = StringBuffer();

    if (inHours > 0) {
      stringBuffer.write(inHours % 24);
      stringBuffer.write(inHours > 1 ? " hours" : " hour");
    }

    if (inMinutes > 0 && inMinutes % 60 != 0) {
      if (inMinutes > 60) stringBuffer.write(", ");
      stringBuffer.write(inMinutes % 60);
      stringBuffer.write(inMinutes % 60 > 1 ? " minutes" : " minute");
    }

    return stringBuffer.toString();
  }
}
