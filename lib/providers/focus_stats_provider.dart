/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:math';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/focus_stats_model.dart';
import 'package:mindful/providers/aggregated_usage_stats_provider.dart';

/// A Riverpod state notifier provider that manages [FocusStatsModel].
final focusStatsProvider =
    StateNotifierProvider<FocusStatsNotifier, FocusStatsModel>((ref) {
  final aggregatedScreenTime = ref
      .watch(aggregatedUsageStatsProvider.select((v) => v.screenTimeThisWeek));
  return FocusStatsNotifier(aggregatedScreenTime);
});

class FocusStatsNotifier extends StateNotifier<FocusStatsModel> {
  final List<int> thisWeeksScreenTime;

  FocusStatsNotifier(this.thisWeeksScreenTime)
      : super(const FocusStatsModel()) {
    refreshFocusStats();
  }

  Future<void> refreshFocusStats() async {
    final dao = DriftDbService.instance.driftDb.dynamicRecordsDao;

    final todaysScreenTime = thisWeeksScreenTime[todayOfWeek];
    final yesterdaysScreenTime = thisWeeksScreenTime[max(0, todayOfWeek - 1)];

    final lifetimeFocusedTime = await dao.fetchLifetimeSessionsDuration();

    final successfulSessions =
        await dao.fetchSessionsCountWithState(SessionState.successful);

    final failedSessions =
        await dao.fetchSessionsCountWithState(SessionState.failed);

    final dateToday = DateTime.now().dateOnly;
    final todaysFocusedTime = await dao.fetchSessionsDurationForInterval(
        dateToday, dateToday.add(1.days));

    final yesterdaysFocusedTime = await dao.fetchSessionsDurationForInterval(
        dateToday.subtract(1.days), dateToday);

    if (!mounted) return;
    state = state.copyWith(
      todaysScreenTime: todaysScreenTime.seconds,
      yesterdaysScreenTime: yesterdaysScreenTime.seconds,
      todaysFocusedTime: todaysFocusedTime.seconds,
      yesterdaysFocusedTime: yesterdaysFocusedTime.seconds,
      lifetimeFocusedTime: lifetimeFocusedTime.seconds,
      successfulSessions: successfulSessions,
      failedSessions: failedSessions,
    );
  }
}
