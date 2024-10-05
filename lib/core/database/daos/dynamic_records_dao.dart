import 'package:drift/drift.dart';

import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/tables/app_restriction_table.dart';
import 'package:mindful/core/database/tables/crash_logs_table.dart';
import 'package:mindful/core/database/tables/focus_sessions_table.dart';

part 'dynamic_records_dao.g.dart';

@DriftAccessor(
  tables: [
    AppRestrictionTable,
    CrashLogsTable,
    FocusSessionsTable,
  ],
)
class DynamicRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$DynamicRecordsDaoMixin {
  DynamicRecordsDao(AppDatabase db) : super(db);

  // Future<MindfulSettings> loadSettings() async =>
  //     await select(mindfulSettingsTable).getSingleOrNull() ??
  //     MindfulSettingsTable.defaultMindfulSettings;

  // Future<void> saveSettings(MindfulSettings settings) async =>
  //     into(mindfulSettingsTable).insert(settings, mode: InsertMode.insertOrReplace);
}
