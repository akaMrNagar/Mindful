final DateTime now = DateTime.now();
final int dayOfWeek = _formatWeekDayToSunday(now.weekday) - 1;

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
