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
import 'package:mindful/core/database/converters/bool_list_converter.dart';
import 'package:mindful/core/database/converters/enum_list_converter.dart';
import 'package:mindful/core/database/converters/notification_schedule_list_converter.dart';
import 'package:mindful/core/database/converters/string_list_converter.dart';
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
import 'package:mindful/core/database/tables/notification_settings_table.dart';
import 'package:mindful/core/database/tables/notifications_table.dart';
import 'package:mindful/core/database/tables/parental_controls_table.dart';
import 'package:mindful/core/database/tables/mindful_settings_table.dart';
import 'package:mindful/core/database/tables/restriction_groups_table.dart';
import 'package:mindful/core/database/tables/shared_unique_data_table.dart';
import 'package:mindful/core/database/tables/wellbeing_table.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/enums/recap_type.dart';
import 'package:mindful/core/enums/reminder_type.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/enums/platform_features.dart';
import 'package:mindful/core/utils/default_models_utils.dart';
import 'package:mindful/models/notification_schedule.dart';
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
    AppUsageTable,
    NotificationSettingsTable,
    NotificationsTable,
  ],
  daos: [UniqueRecordsDao, DynamicRecordsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  // STEP 1 => Modify or create tables
  //
  // STEP 2 => Bump up [schemaVersion]
  //
  // STEP 3 => Rebuild dart api => dart run build_runner build -d
  //
  // STEP 4 => Generate schema => dart run drift_dev schema dump lib/core/database/app_database.dart lib/core/database/schemas
  //
  // STEP 5 => Generate steps => dart run drift_dev schema steps lib/core/database/schemas lib/core/database/schemas/schema_versions.dart
  //
  // STEP 6 => Add migration steps to migration strategy by create new file in migrations folder. See previous migrations for help
  @override
  int get schemaVersion => 9;

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
              from4To5: from4To5,
              from5To6: from5To6,
              from6To7: from6To7,
              from7To8: from7To8,
              from8To9: from8To9,
            ),
          );
        },
      );
}
