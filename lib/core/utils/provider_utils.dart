import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/models/usage_model.dart';

/// Generates a Map<DateTime, int> for the 7 days of the week starting
/// from the given date's start of the week, initializing all values to 0.
Map<DateTime, UsageModel> generateEmptyWeekUsage(DateTime dt) {
  final startOfWeek = dt.startOfWeek;

  return Map.fromEntries(
    List.generate(
        7, (i) => MapEntry(startOfWeek.add(i.days), const UsageModel())),
  );
}
