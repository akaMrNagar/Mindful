/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_animate/flutter_animate.dart';
import 'package:isar/isar.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/models/isar/bedtime_settings.dart';
import 'package:mindful/models/isar/focus_mode_settings.dart';
import 'package:mindful/models/isar/focus_session.dart';
import 'package:mindful/models/isar/restriction_info.dart';
import 'package:mindful/models/isar/app_settings.dart';
import 'package:mindful/models/isar/wellbeing_settings.dart';
import 'package:path_provider/path_provider.dart';

/// A service class responsible for interacting with the Isar database.
///
/// This class provides methods for initializing the Isar database,
/// saving and loading various settings objects.
class IsarDbService {
  /// Private constructor to enforce singleton pattern.
  IsarDbService._();

  /// Singleton instance of the [IsarDbService].
  static final IsarDbService instance = IsarDbService._();

  /// Internal Isar instance used for database operations.
  late Isar _isar;

  /// Initializes the Isar database service.
  ///
  /// This method should be called once in the application's main method
  /// to set up the Isar database.
  Future<void> init() async {
    /// Gets the application's directory path for storing the database.
    final appDirectory = await getApplicationDocumentsDirectory();

    /// Initializes the Isar instance with the specified schemas and directory.
    _isar = await Isar.open(
      [
        AppSettingsSchema,
        WellBeingSettingsSchema,
        BedtimeSettingsSchema,
        RestrictionInfoSchema,
        FocusSessionSchema,
        FocusModeSettingsSchema,
      ],
      directory: appDirectory.path,
    );
  }

  /// Closes ISAR and deletes the database files to free-up memory
  Future<void> closeAndDisposeDb() async => _isar.close(deleteFromDisk: true);

  /// Loads the first (and likely only) [AppSettings] object
  /// from the Isar database. If none exists, returns a new instance.
  Future<AppSettings> loadAppSettings() async =>
      await _isar.appSettings.where().findFirst() ?? const AppSettings();

  /// Loads the first (and likely only) [BedtimeSettings] object
  /// from the Isar database. If none exists, returns a new instance.
  Future<BedtimeSettings> loadBedtimeSettings() async =>
      await _isar.bedtimeSettings.where().findFirst() ??
      const BedtimeSettings();

  /// Loads the first (and likely only) [WellBeingSettings] object
  /// from the Isar database. If none exists, returns a new instance.
  Future<WellBeingSettings> loadWellBeingSettings() async =>
      await _isar.wellBeingSettings.where().findFirst() ??
      const WellBeingSettings();

  /// Loads all [RestrictionInfo] objects from the Isar database,
  /// sorted by their app package.
  Future<List<RestrictionInfo>> loadRestrictionInfos() async =>
      _isar.restrictionInfos.where().sortByAppPackage().findAll();

  /// Loads the first (and likely only) [FocusModeSettings] object
  /// from the Isar database. If none exists, returns a new instance.
  Future<FocusModeSettings> loadFocusModeSettings() async =>
      await _isar.focusModeSettings.where().findFirst() ??
      const FocusModeSettings();

  /// Loads all [FocusSession] objects from the Isar database.
  Future<List<FocusSession>> loadAllSessions() async =>
      await _isar.focusSessions.where().findAll();

  /// Loads all number of days for current running streak from the Isar database.
  ///
  /// A day is included in a streak only if it has at least one Successful session
  Future<int> loadCurrentStreak() async {
    final today = DateTime.now().dateOnly;
    int streak = 0;

    // Start from today and go backwards day by day
    for (int i = 0;; i++) {
      final targetDate = today.subtract(i.days);

      // Query the database to check if there's a session on the targetDate
      final hasSession = await _isar.focusSessions
          .filter()
          .stateEqualTo(SessionState.successful)
          .startTimeMsEpochBetween(
            targetDate.millisecondsSinceEpoch,
            targetDate.add(1.days).millisecondsSinceEpoch,
          )
          .findFirst();

      if (hasSession == null) break;
      streak++;
    }

    return streak;
  }
}
