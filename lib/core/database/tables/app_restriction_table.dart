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

  /// The interval between each usage alert in SECONDS
  IntColumn get alertInterval => integer()();

  ///  Whether to alert user by dialog if false user will be alerted by notification
  BoolColumn get alertByDialog => boolean()();

  /// Flag denoting if this app can access internet or not
  BoolColumn get canAccessInternet => boolean()();

  /// ID of the [RestrictionGroup] this app is associated with or NULL
  IntColumn get associatedGroupId =>
      integer().nullable().withDefault(const Constant(null))();

  static const defaultAppRestrictionModel = AppRestriction(
    appPackage: "",
    timerSec: 0,
    launchLimit: 0,
    alertInterval: 15 * 60, // Every 15 minutes
    alertByDialog: false,
    canAccessInternet: true,
  );
}
