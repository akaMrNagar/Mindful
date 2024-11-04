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

@DataClassName("AppRestriction")
class AppRestrictionTable extends Table {
  /// Package name of the related app
  TextColumn get appPackage => text()();

  @override
  Set<Column<Object>>? get primaryKey => {appPackage};

  /// The timer set for the app in SECONDS
  IntColumn get timerSec => integer()();

  /// The number of times user can launch this app
  IntColumn get launchLimit => integer()();

  /// The max time in user can spend on this app in one session in SECONDS
  IntColumn get sessionTimeSec => integer()();

  /// The time for which the app is blocked after a session in SECONDS
  IntColumn get sessionCoolDownTimeSec => integer()();

  /// Flag denoting if this app can access internet or not
  BoolColumn get canAccessInternet => boolean()();

  /// ID of the [RestrictionGroup] this app is associated with or NULL
  IntColumn get associatedGroupId =>
      integer().nullable().withDefault(const Constant(null))();

  static const defaultAppRestrictionModel = AppRestriction(
    appPackage: "",
    timerSec: 0,
    launchLimit: 0,
    sessionTimeSec: 0,
    sessionCoolDownTimeSec: 0,
    canAccessInternet: true,
  );
}
