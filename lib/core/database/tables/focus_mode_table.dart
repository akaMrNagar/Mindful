import 'package:drift/drift.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/converters/list_converters.dart';
import 'package:mindful/core/enums/session_type.dart';

@DataClassName("FocusMode")
class FocusModeTable extends Table {
  /// Unique ID for focus mode
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// Selected session type
  IntColumn get sessionType => intEnum<SessionType>()();

  /// Flag indicating if to start DND during the focus session
  BoolColumn get shouldStartDnd => boolean()();

  /// List of app's packages which are selected as distracting apps.
  TextColumn get distractingApps => text().map(const ListStringConverter())();

  /// Longest streak (number of days) till now
  IntColumn get longestStreak => integer()();

  /// Current streak (number of days) till now
  IntColumn get currentStreak => integer()();

  /// The [DateTime] when the streak was updated last time
  DateTimeColumn get lastTimeStreakUpdated => dateTime()();

  /// Id of current active [FocusSession]
  IntColumn get activeSessionId => integer().nullable()();

  static final defaultFocusModeModel = FocusMode(
    id: 0,
    sessionType: SessionType.study,
    shouldStartDnd: false,
    distractingApps: [],
    longestStreak: 0,
    currentStreak: 0,
    lastTimeStreakUpdated: DateTime(0),
    activeSessionId: null,
  );
}
