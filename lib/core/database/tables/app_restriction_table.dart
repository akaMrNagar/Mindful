import 'package:drift/drift.dart';

@DataClassName("AppRestriction")
class AppRestrictionTable extends Table {
  /// Package name of the related app
  TextColumn get appPackage => text()();

  @override
  Set<Column<Object>>? get primaryKey => {appPackage};

  /// The timer set for the app in SECONDS
  IntColumn get timerSec => integer()();

  /// Flag denoting if this app can access internet or not
  BoolColumn get canAccessInternet => boolean()();
}
