/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
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
    refreshUsage(isInitialLoad: true);
  }

  void refreshUsage({bool isInitialLoad = false}) async {
    final (haveUsage, cache) = await DriftDbService
        .instance.driftDb.dynamicRecordsDao
        .fetchWeeklyDeviceUsage(weekRange: range);

    /// Only reload todays usage if needed
    if (cache.containsKey(dateToday)) {
      /// Update todays usage
      cache[dateToday] = todaysUsage.values.fold(
        const UsageModel(),
        (prev, e) => prev + e,
      );
    }

    if (!mounted) return;

    state = cache;
    if (!haveUsage && isInitialLoad) _populateAppsUsageHistory();
  }

  /// Populates the database with app's usage history for last 10 days
  Future<void> _populateAppsUsageHistory() async {
    debugPrint("Populating database with last 10 days usage");

    final db = DriftDbService.instance.driftDb;
    List<AppUsageTableCompanion> weeksUsageCompanions = [];

    for (var i = 0; i < 10; i++) {
      final currentDay = dateToday.subtract(i.days);

      /// Fetch usages for the day
      final usages =
          await MethodChannelService.instance.fetchAppsUsageForInterval(
        start: currentDay.subtract(1.days),
        end: currentDay,
      );

      /// Map to companions
      final usageCompanions = usages.entries
          .map(
            (entry) => AppUsageTableCompanion(
              date: Value(currentDay.subtract(1.days)),
              packageName: Value(entry.key),
              screenTime: Value(entry.value.screenTime),
              mobileData: Value(entry.value.mobileData),
              wifiData: Value(entry.value.wifiData),
            ),
          )
          .toList();

      weeksUsageCompanions.addAll(usageCompanions);
    }

    /// Insert all usages to db
    await db.dynamicRecordsDao.insertBatchAppUsages(weeksUsageCompanions);
    debugPrint("Successfully populated database with last 10 days usage");

    /// Refresh provider state
    refreshUsage();
  }
}
