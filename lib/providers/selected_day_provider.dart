import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/utils.dart';

/// Provides an integer indicating a day of the week based on 0 indexed week days,
/// which have been selected in the bar chart.
final selectedDayProvider = StateProvider.autoDispose<int>((ref) => dayOfWeek);
