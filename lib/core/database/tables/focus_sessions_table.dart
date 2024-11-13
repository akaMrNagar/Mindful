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
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/enums/session_type.dart';

@DataClassName("FocusSession")
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
