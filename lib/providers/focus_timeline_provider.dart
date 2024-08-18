import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/models/focus_timeline_model.dart';

/// A Riverpod state notifier provider that manages Focus Timeline.
final focusTimelineProvider =
    StateNotifierProvider<FocusModeNotifier, FocusTimelineModel>(
  (ref) => FocusModeNotifier(),
);

/// This class manages the state of Focus Timeline.
class FocusModeNotifier extends StateNotifier<FocusTimelineModel> {
  DateTime _selectedDay = DateTime(2024);

  FocusModeNotifier() : super(const FocusTimelineModel()) {
    refreshTimeline();
  }

  Future<void> refreshTimeline() async {
    await onMonthChanged(DateTime.now().dateOnly);
    await onDayChanged(DateTime.now().dateOnly);
  }

  Future<void> onDayChanged(DateTime dayDate) async {
    if (dayDate == _selectedDay) return;

    // Start of the day
    final startOfDay = dayDate.dateOnly;
    _selectedDay = startOfDay;

    // End of the day
    final endOfDay = dayDate.copyWith(
      hour: 23,
      minute: 59,
      second: 59,
      millisecond: 999,
    );

    final sessions = await IsarDbService.instance.loadAllSessionsForInterval(
      start: startOfDay,
      end: endOfDay,
    );

    final todaysFocusedTime =
        sessions.fold(0, (prev, e) => prev + e.durationSecs).seconds;

    state = state.copyWith(
      todaysSessions: AsyncData(sessions),
      todaysFocusedTime: todaysFocusedTime,

      /// Manually update selected day Due to the fact that [HeatMapCalendar] does
      /// not allow to change color for the selected day
      daysTypeMap: {...state.daysTypeMap}
        ..updateAll((k, v) => k == _selectedDay ? -1 : 1),
    );
  }

  Future<void> onMonthChanged(DateTime month) async {
    // Start of the month
    final startOfMonth = DateTime(month.year, month.month, 1);

    // End of the month
    final endOfMonth =
        DateTime(month.year, month.month + 1, 1).subtract(1.days);

    final sessions = await IsarDbService.instance.loadAllSessionsForInterval(
      start: startOfMonth,
      end: endOfMonth,
    );

    final totalProductiveTime =
        sessions.fold(0, (prev, e) => prev + e.durationSecs).seconds;

    /// NOTE - Key value for colors
    /// -1 for selected day
    /// 1 for productive days
    var daysTypeMap = Map<DateTime, int>.fromEntries(
      sessions.map((e) => MapEntry(e.startTimeMsEpoch.msToDateOnly, 1)),
    );

    final totalProductiveDays = daysTypeMap.length;

    /// Manually update selected day Due to the fact that [HeatMapCalendar] does
    /// not allow to change color for the selected day

    daysTypeMap.update(
      _selectedDay,
      (_) => -1,
      ifAbsent: () => -1,
    );

    state = state.copyWith(
      daysTypeMap: daysTypeMap,
      totalProductiveDays: totalProductiveDays,
      totalProductiveTime: totalProductiveTime,
    );
  }
}
