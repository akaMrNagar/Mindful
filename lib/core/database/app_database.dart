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
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/converters/list_converters.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/database/daos/unique_records_dao.dart';
import 'package:mindful/core/database/tables/app_restriction_table.dart';
import 'package:mindful/core/database/tables/bedtime_schedule_table.dart';
import 'package:mindful/core/database/tables/crash_logs_table.dart';
import 'package:mindful/core/database/tables/focus_mode_table.dart';
import 'package:mindful/core/database/tables/focus_profile_table.dart';
import 'package:mindful/core/database/tables/focus_sessions_table.dart';
import 'package:mindful/core/database/tables/invincible_mode_table.dart';
import 'package:mindful/core/database/tables/mindful_settings_table.dart';
import 'package:mindful/core/database/tables/restriction_groups_table.dart';
import 'package:mindful/core/database/tables/wellbeing_table.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/enums/session_state.dart';

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
  ],
  daos: [UniqueRecordsDao, DynamicRecordsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
