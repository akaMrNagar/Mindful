/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/crash_log.dart';

/// A service class responsible for logging Crashes in the Isar database.
class CrashLogService {
  /// Private constructor to enforce singleton pattern.
  CrashLogService._();

  /// Singleton instance of the [CrashLogService].
  static final CrashLogService instance = CrashLogService._();

  /// Create a [CrashLog] object from the provided information and stores it in the database
  void recordCrashError(String error, String stackTrace) async {
    /// Create log
    final crashLog = CrashLog(
      appVersion: await MethodChannelService.instance.getAppVersion(),
      error: error,
      stackTrace: stackTrace,
      timeStampEpoch: DateTime.now().millisecondsSinceEpoch,
    );

    /// Insert log to database
    await IsarDbService.instance.insertCrashLog(crashLog);
  }
}
