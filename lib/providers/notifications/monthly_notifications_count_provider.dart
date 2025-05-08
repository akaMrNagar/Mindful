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

final monthlyNotificationsCountProvider = StateNotifierProvider.family<
        MonthlyNotificationsNotifier, Map<DateTime, int>, DateTimeRange>(
    (ref, monthRange) => MonthlyNotificationsNotifier(monthRange));

class MonthlyNotificationsNotifier extends StateNotifier<Map<DateTime, int>> {
  late DynamicRecordsDao _dao;
  final DateTimeRange monthRange;

  MonthlyNotificationsNotifier(this.monthRange) : super({}) {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    refreshTimeline();
  }

  /// Refresh the state
  Future<void> refreshTimeline() async {
    final countsMap = await _dao.fetchNotificationsCountForInterval(
      monthRange.start,
      monthRange.end.add(1.days).subtract(1.seconds),
    );

    if (mounted) {
      state = countsMap;
    }
  }
}
