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
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';

@DataClassName("NotificationSchedule")
class NotificationScheduleTable extends Table {
  /// Unique ID for schedule
  IntColumn get id => integer().autoIncrement()();

  /// Boolean denoting the status of this notification schedule
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  /// Name or Label for the schedule
  TextColumn get label => text().withDefault(const Constant(""))();

  /// [TimeOfDay] in minutes of the schedule.
  /// It is stored as total minutes.
  IntColumn get time => integer() 
      .map(const TimeOfDayAdapterConverter())
      .withDefault(const Constant(0))();
}
