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

@DataClassName("InvincibleMode")
class InvincibleModeTable extends Table {
  /// Unique ID for Invincible Mode settings
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// Flag indicating if invincible mode is ON
  BoolColumn get isInvincibleModeOn => boolean().withDefault(const Constant(false))();

  /// Flag indicating if apps timer are included in the invincible mode
  ///
  /// If included user cannot modify app timer if it is already ran out
  BoolColumn get includeAppsTimer => boolean().withDefault(const Constant(true))();

  /// Flag indicating if apps launch count limit is included in the invincible mode
  ///
  /// If included user cannot modify app launch count limit if it is already ran out
  BoolColumn get includeAppsLaunchLimit => boolean().withDefault(const Constant(false))();

  /// Flag indicating if apps active period is included in the invincible mode
  ///
  /// If included user cannot modify app launch count limit if it is already ran out
  BoolColumn get includeAppsActivePeriod => boolean().withDefault(const Constant(false))();

  /// Flag indicating if groups timer are included in the invincible mode
  ///
  /// If included user cannot modify group timer if it is already ran out
  BoolColumn get includeGroupsTimer => boolean().withDefault(const Constant(false))();

  /// Flag indicating if groups active period is included in the invincible mode
  ///
  /// If included user cannot modify group timer if it is already ran out
  BoolColumn get includeGroupsActivePeriod => boolean().withDefault(const Constant(false))();

  /// Flag indicating if short content's timer is included in the invincible mode
  ///
  /// If included user cannot modify short content timer if it is already ran out
  BoolColumn get includeShortsTimer => boolean().withDefault(const Constant(false))();

  /// Flag indicating if bedtime schedule is included in the invincible mode
  ///
  /// If included user cannot modify bedtime schedule during the active period
  BoolColumn get includeBedtimeSchedule => boolean().withDefault(const Constant(false))();
}
