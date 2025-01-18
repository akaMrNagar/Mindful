  import 'package:mindful/core/extensions/ext_date_time.dart';

/// Get the date for today (Midnight 12).
/// The returned date will not have any time set.
///
/// Ex- 2025-01-01 00:00:00:000
DateTime get dateToday => DateTime.now().dateOnly;