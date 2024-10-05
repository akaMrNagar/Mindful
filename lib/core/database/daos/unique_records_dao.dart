import 'package:drift/drift.dart';

import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/tables/bedtime_schedule_table.dart';
import 'package:mindful/core/database/tables/focus_mode_table.dart';
import 'package:mindful/core/database/tables/mindful_settings_table.dart';
import 'package:mindful/core/database/tables/wellbeing_table.dart';

part 'unique_records_dao.g.dart';

@DriftAccessor(
  tables: [
    MindfulSettingsTable,
    BedtimeScheduleTable,
    FocusModeTable,
    WellbeingTable,
  ],
)
class UniqueRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$UniqueRecordsDaoMixin {
  UniqueRecordsDao(AppDatabase db) : super(db);

  Future<MindfulSettings> loadSettings() async =>
      await select(mindfulSettingsTable).getSingleOrNull() ??
      MindfulSettingsTable.defaultMindfulSettingsModel;

  Future<void> saveSettings(MindfulSettings settings) async =>
      into(mindfulSettingsTable)
          .insert(settings, mode: InsertMode.insertOrReplace);
}
