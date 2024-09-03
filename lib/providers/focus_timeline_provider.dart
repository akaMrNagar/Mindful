/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/models/focus_timeline_model.dart';

/// A Riverpod state notifier provider that manages Focus Timeline.
final focusTimelineProvider =
    StateNotifierProvider<FocusModeNotifier, FocusTimelineModel>(
  (ref) => FocusModeNotifier(),
);

/// This class manages the state of Focus Timeline.
class FocusModeNotifier extends StateNotifier<FocusTimelineModel> {
  FocusModeNotifier() : super(const FocusTimelineModel()) {
    refreshTimeline();
  }

  /// Refresh the state
  Future<void> refreshTimeline() async {
    await onMonthChanged(DateTime.now().dateOnly);
    await onDayChanged(DateTime.now().dateOnly);
  }

  /// Reload the list of focus session when the selected DAY changes
  Future<void> onDayChanged(DateTime dayDate) async {
    // Start of the day
    final startOfDay = dayDate.dateOnly;

    // End of the day
    final endOfDay = dayDate.copyWith(
      hour: 23,
      minute: 59,
      second: 59,
      millisecond: 999,
    );

    var sessions = await IsarDbService.instance.loadAllSessionsForInterval(
      start: startOfDay,
      end: endOfDay,
    );

    sessions.removeWhere((e) => e.state == SessionState.active);

    final todaysFocusedTime =
        sessions.fold(0, (prev, e) => prev + e.durationSecs).seconds;

    state = state.copyWith(
      todaysSessions: AsyncData(sessions),
      todaysFocusedTime: todaysFocusedTime,
    );
  }

  /// Reload focus session states when the selected MONTH changes
  Future<void> onMonthChanged(DateTime month) async {
    // Start of the month
    final startOfMonth = DateTime(month.year, month.month, 1);

    // End of the month
    final endOfMonth =
        DateTime(month.year, month.month + 1, 1).subtract(1.days);

    var sessions = await IsarDbService.instance.loadAllSessionsForInterval(
      start: startOfMonth,
      end: endOfMonth,
    );

    sessions.removeWhere((e) => e.state == SessionState.active);

    final totalProductiveTime =
        sessions.fold(0, (prev, e) => prev + e.durationSecs).seconds;

    final productiveDaysMap = Map.fromEntries(
      sessions.map(
        (e) => MapEntry(e.startTime.dateOnly, 1),
      ),
    );

    state = state.copyWith(
      daysTypeMap: productiveDaysMap,
      totalProductiveDays: productiveDaysMap.length,
      totalProductiveTime: totalProductiveTime,
    );
  }
}
