import 'package:drift/drift.dart';
import 'package:mindful/core/database/converters/list_converters.dart';

@DataClassName("RestrictionGroup")
class RestrictionGroupsTable extends Table {
  /// Unique ID for each restriction group
  IntColumn get id => integer().autoIncrement()();

  /// Name of the group
  TextColumn get groupName => text()();

  /// The timer set for the group in SECONDS
  IntColumn get timerSec => integer()();

  /// List of app's packages which are associated with the group.
  TextColumn get distractingApps => text().map(const ListStringConverter())();
}
