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

import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/tables/bedtime_schedule_table.dart';
import 'package:mindful/core/database/tables/focus_mode_table.dart';
import 'package:mindful/core/database/tables/invincible_mode_table.dart';
import 'package:mindful/core/database/tables/mindful_settings_table.dart';
import 'package:mindful/core/database/tables/wellbeing_table.dart';

part 'unique_records_dao.g.dart';

@DriftAccessor(
  tables: [
    MindfulSettingsTable,
    InvincibleModeTable,
    BedtimeScheduleTable,
    FocusModeTable,
    WellbeingTable,
  ],
)
class UniqueRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$UniqueRecordsDaoMixin {
  UniqueRecordsDao(AppDatabase db) : super(db);

  /// Saves a single [MindfulSettings] object to the database.
  Future<void> saveMindfulSettings(MindfulSettings settings) async =>
      into(mindfulSettingsTable)
          .insert(settings, mode: InsertMode.insertOrReplace);

  /// Loads the first (and likely only) [MindfulSettings] object
  /// from the database. If none exists, returns default instance.
  Future<MindfulSettings> loadMindfulSettings() async =>
      await select(mindfulSettingsTable).getSingleOrNull() ??
      MindfulSettingsTable.defaultMindfulSettingsModel;

  /// Saves a single [InvincibleMode] object to the database.
  Future<void> saveInvincibleModeSettings(
          InvincibleMode invincibleModeSettings) async =>
      into(invincibleModeTable)
          .insert(invincibleModeSettings, mode: InsertMode.insertOrReplace);

  /// Loads the first (and likely only) [InvincibleMode] object
  /// from the database. If none exists, returns default instance.
  Future<InvincibleMode> loadInvincibleModeSettings() async =>
      await select(invincibleModeTable).getSingleOrNull() ??
      InvincibleModeTable.defaultInvincibleModeModel;

  /// Saves a single [BedtimeSchedule] object to the database.
  Future<void> saveBedtimeSchedule(BedtimeSchedule bedtimeSchedule) async =>
      into(bedtimeScheduleTable)
          .insert(bedtimeSchedule, mode: InsertMode.insertOrReplace);

  /// Loads the first (and likely only) [BedtimeSchedule] object
  /// from the database. If none exists, returns default instance.
  Future<BedtimeSchedule> loadBedtimeSchedule() async =>
      await select(bedtimeScheduleTable).getSingleOrNull() ??
      BedtimeScheduleTable.defaultBedtimeScheduleModel;

  /// Saves a single [FocusMode] object to the database.
  Future<void> saveFocusModeSettings(FocusMode focusMode) async =>
      into(focusModeTable).insert(focusMode, mode: InsertMode.insertOrReplace);

  /// Loads the first (and likely only) [FocusMode] object
  /// from the database. If none exists, returns default instance.
  Future<FocusMode> loadFocusModeSettings() async =>
      await select(focusModeTable).getSingleOrNull() ??
      FocusModeTable.defaultFocusModeModel;

  /// Saves a single [Wellbeing] object to the database.
  Future<void> saveWellBeingSettings(Wellbeing wellbeing) async =>
      into(wellbeingTable).insert(wellbeing, mode: InsertMode.insertOrReplace);

  /// Loads the first (and likely only) [Wellbeing] object
  /// from the database. If none exists, returns default instance.
  Future<Wellbeing> loadWellBeingSettings() async =>
      await select(wellbeingTable).getSingleOrNull() ??
      WellbeingTable.defaultWellbeingModel;
}
