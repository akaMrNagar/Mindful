// ignore_for_file: empty_catches

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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';

/// A service class responsible for logging Crashes in the Isar database.
class CrashLogService {
  /// Private constructor to enforce singleton pattern.
  CrashLogService._();

  /// Singleton instance of the [CrashLogService].
  static CrashLogService instance = CrashLogService._();

  /// Initialize crash log service and load and add logs from native side to drift db
  ///
  /// Must be called after initializing [MethodChannelService] and [DriftDbService]
  Future<void> init() async {
    Future.delayed(3.seconds, loadLogsFromNativeToDriftDb);
  }

  /// Load logs from native side and insert them to drift db then clear them on native side
  void loadLogsFromNativeToDriftDb() async {
    try {
      /// Load logs
      final nativeLogs =
          await MethodChannelService.instance.getNativeCrashLogs();

      if (nativeLogs.isEmpty) return;

      /// Insert logs to db
      await DriftDbService.instance.driftDb.dynamicRecordsDao
          .insertCrashLogs(nativeLogs);

      /// Clear logs on native side
      await MethodChannelService.instance.clearNativeCrashLogs();

      /// Remove logs older than 1 month from db
      await DriftDbService.instance.driftDb.dynamicRecordsDao
          .removeCrashLogOlderThanDate(DateTime.now().subtract(30.days));
    } catch (e) {}
  }

  /// Create a [CrashLog] object from the provided information and stores it in the database
  void recordCrashError(String error, String stackTrace) async {
    /// Create log
    final crashLog = CrashLogsTableCompanion.insert(
      appVersion:
          Value(MethodChannelService.instance.deviceInfo.mindfulVersion),
      error: Value(error),
      stackTrace: Value(stackTrace),
      timeStamp: Value(DateTime.now()),
    );

    /// Insert log to database
    await DriftDbService.instance.driftDb.dynamicRecordsDao
        .insertCrashLog(crashLog);
  }
}
