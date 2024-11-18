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
import 'package:mindful/core/database/converters/list_converters.dart';
import 'package:mindful/core/enums/session_type.dart';

@DataClassName("FocusProfile")
class FocusProfileTable extends Table {
  /// Selected session type
  IntColumn get sessionType => intEnum<SessionType>()();

  @override
  Set<Column<Object>>? get primaryKey => {sessionType};

  /// Duration in SECONDS for the focus session
  IntColumn get sessionDuration => integer()();

  /// Flag indicating if to start DND during the focus session
  BoolColumn get shouldStartDnd => boolean()();

  /// List of app's packages which are selected as distracting apps.
  TextColumn get distractingApps => text().map(const ListStringConverter())();

  static const defaultFocusProfileModel = FocusProfile(
    sessionType: SessionType.study,
    sessionDuration: 0,
    shouldStartDnd: false,
    distractingApps: [],
  );
}
