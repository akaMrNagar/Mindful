/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/converters/list_converters.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/database/daos/unique_records_dao.dart';
import 'package:mindful/core/database/schemas/schema_versions.dart';
import 'package:mindful/core/database/tables/app_restriction_table.dart';
import 'package:mindful/core/database/tables/app_usage_table.dart';
import 'package:mindful/core/database/tables/bedtime_schedule_table.dart';
import 'package:mindful/core/database/tables/crash_logs_table.dart';
import 'package:mindful/core/database/tables/focus_mode_table.dart';
import 'package:mindful/core/database/tables/focus_profile_table.dart';
import 'package:mindful/core/database/tables/focus_sessions_table.dart';
import 'package:mindful/core/database/tables/invincible_mode_table.dart';
import 'package:mindful/core/database/tables/mindful_settings_table.dart';
import 'package:mindful/core/database/tables/notification_schedule_table.dart';
import 'package:mindful/core/database/tables/restriction_groups_table.dart';
import 'package:mindful/core/database/tables/shared_unique_data_table.dart';
import 'package:mindful/core/database/tables/wellbeing_table.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/utils/db_utils.dart';
import 'package:mindful/core/utils/default_models_utils.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AppRestrictionTable,
    BedtimeScheduleTable,
    CrashLogsTable,
    FocusModeTable,
    FocusProfileTable,
    FocusSessionsTable,
    MindfulSettingsTable,
    InvincibleModeTable,
    RestrictionGroupsTable,
    WellbeingTable,
    SharedUniqueDataTable,
    NotificationScheduleTable,
    AppUsageTable,
  ],
  daos: [UniqueRecordsDao, DynamicRecordsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  // STEP 1 => generate schema => dart run drift_dev schema dump lib/core/database/app_database.dart lib/core/database/schemas
  //
  // STEP 2 => generate steps => dart run drift_dev schema steps lib/core/database/schemas lib/core/database/schemas/schema_versions.dart
  //
  // STEP 3 => Add migration steps to migration strategy
  @override
  int get schemaVersion => 3;

  /// Will be called when the Drift Database is created for the first time
  ///
  /// Do the initialization or migration from ISAR
  Future<void> _onFirstTimeDbCreate(Migrator migrator) async {
    await runSafe(
      "_onFirstTimeDbCreate()",
      () async {
        /// Create all tables
        await migrator.createAll();
        await IsarDbService.instance.init();
        final db = migrator.database;

        /// restore mindful settings
        debugPrint("Restoring app settings from ISAR");
        final oldSettings = await IsarDbService.instance.loadAppSettings();
        await db.into(mindfulSettingsTable).insert(
              defaultMindfulSettingsModel.copyWith(
                username: oldSettings.username,
                accentColor: oldSettings.color,
                themeMode: AppThemeMode.values[oldSettings.themeMode.index],
                dataResetTime:
                    TimeOfDayAdapter.fromMinutes(oldSettings.dataResetTimeMins),
                useBottomNavigation: oldSettings.bottomNavigation,
                useAmoledDark: oldSettings.amoledDark,
              ),
              mode: InsertMode.insertOrReplace,
            );

        /// restore wellbeing settings
        debugPrint("Restoring wellbeing settings from ISAR");
        final oldWellbeing =
            await IsarDbService.instance.loadWellBeingSettings();
        await db.into(wellbeingTable).insert(
              defaultWellbeingModel.copyWith(
                allowedShortsTimeSec: oldWellbeing.allowedShortContentTimeSec,
                blockInstaReels: oldWellbeing.blockFbReels,
                blockYtShorts: oldWellbeing.blockYtShorts,
                blockFbReels: oldWellbeing.blockFbReels,
                blockSnapSpotlight: oldWellbeing.blockSnapSpotlight,
                blockRedditShorts: oldWellbeing.blockRedditShorts,
                blockNsfwSites: oldWellbeing.blockNsfwSites,
                blockedWebsites: oldWellbeing.blockedWebsites,
              ),
              mode: InsertMode.insertOrReplace,
            );

        /// restore bedtime settings
        debugPrint("Restoring bedtime schedule settings from ISAR");
        final oldBedtime = await IsarDbService.instance.loadBedtimeSettings();
        final bedtimeStart =
            TimeOfDayAdapter.fromMinutes(oldBedtime.startTimeInMins);
        final bedtimeEnd =
            TimeOfDayAdapter.fromMinutes(oldBedtime.endTimeInMins);
        await db.into(bedtimeScheduleTable).insert(
              defaultBedtimeScheduleModel.copyWith(
                scheduleStartTime: bedtimeStart,
                scheduleEndTime: bedtimeEnd,
                scheduleDurationInMins:
                    bedtimeEnd.difference(bedtimeStart).inMinutes,
                scheduleDays: oldBedtime.scheduleDays,
                distractingApps: oldBedtime.distractingApps,
              ),
              mode: InsertMode.insertOrReplace,
            );

        /// restore focus mode settings
        debugPrint("Restoring focus mode info from ISAR");
        final oldFocusMode =
            await IsarDbService.instance.loadFocusModeSettings();
        final currentStreak = await IsarDbService.instance.loadCurrentStreak();
        await db.into(focusModeTable).insert(
              defaultFocusModeModel.copyWith(
                currentStreak: currentStreak,
                longestStreak: oldFocusMode.longestStreak,
                lastTimeStreakUpdated: oldFocusMode.lastStreakUpdatedDay,
              ),
              mode: InsertMode.insertOrReplace,
            );

        /// restore app restrictions
        debugPrint("Restoring app restrictions from ISAR");
        final oldAppRestrictions =
            await IsarDbService.instance.loadRestrictionInfos();
        final newAppRestrictions = oldAppRestrictions
            .map(
              (e) => defaultAppRestrictionModel.copyWith(
                appPackage: e.appPackage,
                timerSec: e.timerSec,
                canAccessInternet: e.internetAccess,
              ),
            )
            .toList();

        await db.batch(
          (batch) => batch.insertAll(
            appRestrictionTable,
            newAppRestrictions,
            mode: InsertMode.insertOrReplace,
          ),
        );

        /// restore focus sessions
        debugPrint("Restoring focus sessions from ISAR");
        final oldSessions = await IsarDbService.instance.loadAllSessions();
        final newSessions = oldSessions
            .map(
              (e) => FocusSessionsTableCompanion(
                type: Value(e.type),
                state: Value(e.state),
                startDateTime: Value(e.startTime),
                durationSecs: Value(e.durationSecs),
              ),
            )
            .toList();

        await db.batch(
          (batch) => batch.insertAll(
            focusSessionsTable,
            newSessions,
            mode: InsertMode.insertOrReplace,
          ),
        );

        /// disposing ISAR
        debugPrint("Restoration completed, now disposing ISAR");
        await IsarDbService.instance.closeAndDisposeDb();
      },
    );
  }

  // Always use [runSafe()] for upgrades - why?
  // If a user imports a backup from a newer schema when they are on an older
  // App version, it will import correctly. However, when they do update the app
  // The migrator will run and it will throw error!
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: _onFirstTimeDbCreate,
        onUpgrade: (m, from, to) async {
          debugPrint("Upgrading database from schema version $from to $to");

          return m.runMigrationSteps(
            from: from,
            to: to,
            steps: migrationSteps(
              from1To2: (m, schema) async => runSafe(
                "Migration($from to $to)",
                () async {
                  /// Add protective access [Bool] column
                  await m.addColumn(
                    schema.mindfulSettingsTable,
                    schema.mindfulSettingsTable.protectedAccess,
                  );

                  /// Add uninstall window time [TimeOfDayAdapter] column
                  await m.addColumn(
                    schema.mindfulSettingsTable,
                    schema.mindfulSettingsTable.uninstallWindowTime,
                  );
                },
              ),
              from2To3: (m, schema) async => runSafe(
                "Migration($from to $to)",
                () async {
                  /// Create notification schedule table
                  await m.createTable(notificationScheduleTable);

                  /// Create shared unique data table
                  await m.createTable(sharedUniqueDataTable);

                  /// Fetch excluded apps from [MindfulSettingsTable]
                  final settings = await m.database
                      .select(mindfulSettingsTable)
                      .getSingleOrNull();

                  /// Insert excluded apps to [SharedUniqueDataTable]
                  if (settings != null) {
                    /// Get record
                    final record = await m.database
                        .customSelect(
                          'SELECT excluded_apps FROM mindful_settings_table',
                        )
                        .getSingleOrNull();

                    /// Decode to list
                    List<String> excludedApps = List.from(
                      jsonDecode(record?.data['excluded_apps'] ?? '[]'),
                    );

                    /// Insert to table
                    await m.database.into(sharedUniqueDataTable).insert(
                          SharedUniqueDataTableCompanion(
                            excludedApps: Value(excludedApps),
                          ),
                          mode: InsertMode.insertOrReplace,
                        );
                  }

                  /// Drop excluded apps column from [MindfulSettingsTable]
                  await m.alterTable(TableMigration(mindfulSettingsTable));
                },
              ),
            ),
          );
        },
      );
}
