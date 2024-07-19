
final DateTime now = DateTime.now();
final int dayOfWeek = _formatWeekDayToSunday(now.weekday) - 1;

/// In java first day of week is SUNDAY but in dart fist day of week is MONDAY
/// so offset days
int _formatWeekDayToSunday(int weekDay) {
  // print("incoming: $weekDay");
  return switch (weekDay) {
    DateTime.monday => DateTime.tuesday,
    DateTime.tuesday => DateTime.wednesday,
    DateTime.wednesday => DateTime.thursday,
    DateTime.thursday => DateTime.friday,
    DateTime.friday => DateTime.saturday,
    DateTime.saturday => DateTime.sunday,
    DateTime.sunday => DateTime.monday,
    int() => 1,
  };
}
