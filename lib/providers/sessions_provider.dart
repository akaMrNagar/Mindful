// A Riverpod state notifier provider that manages global application settings.
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/models/isar/focus_session.dart';

/// A Riverpod state notifier provider that manages async list of [FocusSession] for selected day.
final sessionsProvider =
    StateNotifierProvider<SessionsNotifier, AsyncValue<List<FocusSession>>>(
  (ref) => SessionsNotifier(),
);

/// This class manages the state of async list of [FocusSession] for selected day.
class SessionsNotifier extends StateNotifier<AsyncValue<List<FocusSession>>> {
  /// The currently selected month to fetch focus sessions
  SessionsNotifier() : super(const AsyncLoading()) {
    loadSessionsForDay(DateTime.now());
  }

  Future<void> loadSessionsForDay(DateTime dayDateTime) async {
    // Start of the month
    final startOfDay = dayDateTime.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );

    // End of the month
    final endOfDay = dayDateTime.copyWith(
      hour: 23,
      minute: 59,
      second: 59,
      millisecond: 999,
    );

    final sessions = await IsarDbService.instance.loadAllSessionsForInterval(
      start: startOfDay,
      end: endOfDay,
    );

    state = AsyncData(sessions);
  }

  Future<Map<DateTime, int>> loadHeatmapDataSetsForMonth({
    required DateTime month,
  }) async {
    // Start of the month
    final startOfMonth = DateTime(month.year, month.month, 1);

    // End of the month
    final endOfMonth =
        DateTime(month.year, month.month + 1, 1).subtract(1.days);

    var dates = await IsarDbService.instance.loadProductiveDatesForInterval(
      start: startOfMonth,
      end: endOfMonth,
    );

    return Map.fromEntries(
      dates.map((e) => MapEntry(e.msToDateOnly, 1)),
    );
  }
}
