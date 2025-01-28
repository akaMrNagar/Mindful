/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/models/monthly_focus_model.dart';

/// A Riverpod state notifier provider that manages [MonthlyFocusModel].
final monthlyFocusProvider = StateNotifierProvider.family<FocusModeNotifier,
    MonthlyFocusModel, DateTimeRange>(
  (ref, monthRange) => FocusModeNotifier(monthRange),
);

/// This class manages the state of Focus Timeline.
class FocusModeNotifier extends StateNotifier<MonthlyFocusModel> {
  late DynamicRecordsDao _dao;
  final DateTimeRange monthRange;

  FocusModeNotifier(this.monthRange) : super(const MonthlyFocusModel()) {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    refreshTimeline();
  }

  /// Refresh the state
  Future<void> refreshTimeline() async {
    final productiveDaysMap = await _dao.fetchSessionsDurationMapForInterval(
      monthRange.start,
      monthRange.end.add(1.days).subtract(1.seconds),
    );

    final totalProductiveTime =
        productiveDaysMap.values.fold(0, (a, b) => a + b);

    state = state.copyWith(
      monthlyFocus: productiveDaysMap,
      totalProductiveDays: productiveDaysMap.length,
      totalProductiveTime: totalProductiveTime.seconds,
    );
  }
}
