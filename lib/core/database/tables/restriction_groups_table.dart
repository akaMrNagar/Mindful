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
