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
import 'package:mindful/core/database/tables/parental_controls_table.dart';
import 'package:mindful/core/database/tables/mindful_settings_table.dart';
import 'package:mindful/core/database/tables/notification_schedule_table.dart';
import 'package:mindful/core/database/tables/restriction_groups_table.dart';
import 'package:mindful/core/database/tables/shared_unique_data_table.dart';
import 'package:mindful/core/database/tables/wellbeing_table.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/enums/shorts_platform_features.dart';
import 'migrations/migrations.dart';

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
    ParentalControlsTable,
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
  int get schemaVersion => 4;

  // Always use [runSafe()] for upgrades - why?
  // If a user imports a backup from a newer schema when they are on an older
  // App version, it will import correctly. However, when they do update the app
  // The migrator will run and it will throw error!
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => await m.createAll(),
        onUpgrade: (m, from, to) async {
          debugPrint("Upgrading database from schema version $from to $to");

          return m.runMigrationSteps(
            from: from,
            to: to,
            steps: migrationSteps(
              from1To2: from1To2,
              from2To3: from2To3,
              from3To4: from3To4,
            ),
          );
        },
      );
}
