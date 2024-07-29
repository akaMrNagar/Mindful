extension ExtDuration on Duration {
  /// Formats the duration into time like '5h 45m' or '54m'
  String toTimeShort() {
    return inMinutes >= 60
        ? inMinutes % 60 == 0
            ? "${inHours}h"
            : "${inHours}h  ${inMinutes % 60}m"
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
