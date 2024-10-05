import 'package:drift/drift.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/enums/session_type.dart';

@DataClassName("FocusSessions")
class FocusSessionsTable extends Table {
  /// Unique ID for each focus session
  IntColumn get id => integer().autoIncrement()();

  /// Type of focus session [SessionType]
  IntColumn get type => intEnum<SessionType>()();

  /// Current state of focus session [SessionState]
  IntColumn get state => intEnum<SessionState>()();

  /// [DateTime] when the focus session is started
  DateTimeColumn get startDateTime => dateTime()();

  /// Total duration of the focus session in SECONDS
  /// If the session state is [SessionState.failed] then the duration
  /// is considered as the time spent before giveup
  IntColumn get durationSecs => integer()();
}
