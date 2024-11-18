/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/models/focus_timeline_model.dart';

/// A Riverpod state notifier provider that manages [FocusTimelineModel].
final focusTimelineProvider =
    StateNotifierProvider<FocusModeNotifier, FocusTimelineModel>(
  (ref) => FocusModeNotifier(),
);

/// This class manages the state of Focus Timeline.
class FocusModeNotifier extends StateNotifier<FocusTimelineModel> {
  late DynamicRecordsDao _dao;

  FocusModeNotifier() : super(const FocusTimelineModel()) {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
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

    var sessions = await _dao.fetchAllSessionsForInterval(
      start: startOfDay,
      end: endOfDay,
    );

    final todaysFocusedTime = sessions
        .fold(
          0,
          (prev, e) =>
              prev + (e.state == SessionState.active ? 0 : e.durationSecs),
        )
        .seconds;

    state = state.copyWith(
      selectedDaysSessions: AsyncData(sessions),
      selectedDaysFocusedTime: todaysFocusedTime,
    );
  }

  /// Reload focus session states when the selected MONTH changes
  Future<void> onMonthChanged(DateTime month) async {
    final productiveDaysMap = await _dao.fetchSessionsDurationMapForInterval(
      month.startOfMonth,
      month.endOfMonth,
    );

    final totalProductiveTime =
        productiveDaysMap.values.fold(0, (a, b) => a + b);

    state = state.copyWith(
      daysTypeMap: productiveDaysMap,
      totalProductiveDays: productiveDaysMap.length,
      totalProductiveTime: totalProductiveTime.seconds,
    );
  }
}
