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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/core/utils/provider_utils.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/providers/usage/todays_apps_usage_provider.dart';

/// Provides aggregated device usage based on day for current week.
/// This includes screen time, wifi usage, and mobile usage
///
/// For all apps on device
final weeklyDeviceUsageProvider = StateNotifierProvider.family<
    WeeklyDeviceUsageNotifier, Map<DateTime, UsageModel>, DateTimeRange>(
  (ref, dateRange) => WeeklyDeviceUsageNotifier(
    dateRange,
    ref.watch(todaysAppsUsageProvider).value ?? {},
  ),
);

class WeeklyDeviceUsageNotifier
    extends StateNotifier<Map<DateTime, UsageModel>> {
  final DateTimeRange range;
  final Map<String, UsageModel> todaysUsage;

  WeeklyDeviceUsageNotifier(this.range, this.todaysUsage)
      : super(generateEmptyWeekUsage(range.start)) {
    refreshUsage();
  }

  void refreshUsage() async {
    final cache = await DriftDbService.instance.driftDb.dynamicRecordsDao
        .fetchWeeklyDeviceUsage(weekRange: range);

    /// Only reload todays usage if needed
    if (cache.containsKey(dateToday)) {
      cache[dateToday] = todaysUsage.values.fold(
        const UsageModel(),
        (prev, e) => prev + e,
      );
    }

    state = cache;
  }
}
