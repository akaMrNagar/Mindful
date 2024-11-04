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

@DataClassName("CrashLogs")
class CrashLogsTable extends Table {
  /// Unique ID for crash logs
  IntColumn get id => integer().autoIncrement()();

  /// Current version of Mindful app
  TextColumn get appVersion => text()();

  /// [DateTime] when the error was thrown
  DateTimeColumn get timeStamp => dateTime()();

  /// The error string
  TextColumn get error => text()();

  /// Stack trace when the error or exception was thrown
  TextColumn get stackTrace => text()();
}
