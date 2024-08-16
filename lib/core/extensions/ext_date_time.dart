extension ExtDateTime on DateTime {
  /// Returns the object with date only while resetting all time related field to 0
  DateTime get dateOnly => copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
}
