import 'package:drift/drift.dart';

@DataClassName("CrashLogs")
class CrashLogsTable extends Table {
  /// Unique ID for crash logs
  IntColumn get id => integer().autoIncrement()();

  /// Current version of Mindful app
  TextColumn get appVersion => text()();

  /// [DateTime] when the error was thrown
  DateTimeColumn get timeStampEpoch => dateTime()();

  /// The error string
  TextColumn get error => text()();

  /// Stack trace when the error or exception was thrown
  TextColumn get stackTrace => text()();
}
