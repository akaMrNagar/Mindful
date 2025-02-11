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
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/models/dated_focus_model.dart';
import 'package:mindful/providers/focus/focus_mode_provider.dart';

/// A Riverpod state notifier provider that manages [DatedFocusModel].
final datedFocusProvider =
    StateNotifierProvider.family<FocusModeNotifier, DatedFocusModel, DateTime>(
  (ref, day) {
    if (day == dateToday) {
      ref.watch(focusModeProvider.select((v) => v.activeSession));
    }
    return FocusModeNotifier(day);
  },
);

/// This class manages the state of Focus Timeline.
class FocusModeNotifier extends StateNotifier<DatedFocusModel> {
  late DynamicRecordsDao _dao;
  final DateTime selectedDay;

  FocusModeNotifier(this.selectedDay) : super(const DatedFocusModel()) {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    refreshTimeline();
  }

  /// Refresh the state
  Future<void> refreshTimeline() async {
    // Start of the day
    final startOfDay = selectedDay.dateOnly;

    // End of the day
    final endOfDay = startOfDay.copyWith(
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
}
