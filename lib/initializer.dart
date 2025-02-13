import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/providers/apps/apps_info_provider.dart';
import 'package:mindful/providers/focus/focus_mode_provider.dart';
import 'package:mindful/providers/restrictions/apps_restrictions_provider.dart';
import 'package:mindful/providers/restrictions/bedtime_provider.dart';
import 'package:mindful/providers/restrictions/restriction_groups_provider.dart';
import 'package:mindful/providers/restrictions/wellbeing_provider.dart';
import 'package:mindful/providers/usage/weekly_device_usage_provider.dart';

/// Initializer to initialize necessary things post onboarding or pre home screen
class Initializer {
  /// Initializes all the necessary providers and restarts services if needed
  static void initializeNecessaryProviders(WidgetRef ref) {
    ref.read(appsInfoProvider);
    ref.read(appsRestrictionsProvider);
    ref.read(restrictionGroupsProvider);
    ref.read(bedtimeScheduleProvider);
    ref.read(wellBeingProvider);
    ref.read(focusModeProvider);
    debugPrint("Necessary providers initialized.");
  }

  /// Populates the database if required
  static Future<void> populateDatabaseIfNecessary(WidgetRef ref) async {
    /// Return if no need to populate
    if (!DriftDbService.instance.doesDbNeedsToPopulate) {
      return;
    }

    /// Populate apps usage
    await _populateAppsUsageHistory(ref);

    /// NOTE: Add more database population methods here if needed
  }

  /// Populates the database with app's usage history for last 10 days
  static Future<void> _populateAppsUsageHistory(WidgetRef ref) async {
    final db = DriftDbService.instance.driftDb;
    final alreadyHaveUsage = await db.dynamicRecordsDao.doesThisWeekHaveUsage();

    /// Return if this week has usage
    if (alreadyHaveUsage) {
      debugPrint("This week's usages is already present in database");
      return;
    }

    debugPrint("Populating database with last 10 days usage");
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

    /// Refresh weekly usage provider
    ref
        .read(weeklyDeviceUsageProvider(dateToday.weekRange).notifier)
        .refreshUsage();
  }
}
