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
