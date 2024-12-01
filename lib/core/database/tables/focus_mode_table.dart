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
import 'package:mindful/core/enums/session_type.dart';

@DataClassName("FocusMode")
class FocusModeTable extends Table {
  /// Unique ID for focus mode
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// Selected session type
  IntColumn get sessionType =>
      intEnum<SessionType>().withDefault(const Constant(0))();

  /// Longest streak (number of days) till now
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();

  /// Current streak (number of days) till now
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();

  /// The [DateTime] when the streak was updated last time
  DateTimeColumn get lastTimeStreakUpdated =>
      dateTime().withDefault(Constant(DateTime(0)))();

  static final defaultFocusModeModel = FocusMode(
    id: 0,
    sessionType: SessionType.study,
    longestStreak: 0,
    currentStreak: 0,
    lastTimeStreakUpdated: DateTime(0),
  );
}
