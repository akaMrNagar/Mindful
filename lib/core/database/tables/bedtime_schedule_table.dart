/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/converters/bool_list_converter.dart';
import 'package:mindful/core/database/converters/string_list_converter.dart';

@DataClassName("BedtimeSchedule")
class BedtimeScheduleTable extends Table {
  /// Unique ID for bedtime schedule
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// [TimeOfDay] in minutes from where the bedtime schedule task will start.
  /// It is stored as total minutes.
  IntColumn get scheduleStartTime => integer()
      .map(const TimeOfDayAdapterConverter())
      .withDefault(const Constant(0))();

  /// [TimeOfDay] in minutes when the bedtime schedule task will end
  /// It is stored as total minutes.
  IntColumn get scheduleEndTime => integer()
      .map(const TimeOfDayAdapterConverter())
      .withDefault(const Constant(0))();

  /// Total duration of bedtime schedule from start to end in MINUTES
  IntColumn get scheduleDurationInMins =>
      integer().withDefault(const Constant(0))();

  /// Days on which the task will execute.
  /// The list contains 7 booleans for each day of week.
  /// [TRUE] indicates that schedule task will run that day.
  /// [FALSE] indicates that schedule task will skip that day.
  TextColumn get scheduleDays =>
      text().map(const BoolListConverter()).withDefault(
          Constant(jsonEncode([true, true, true, true, true, false, false])))();

  /// Boolean denoting the status of the bedtime schedule means
  /// [For User] if the schedule is running or not.
  /// [For Developer]  if the task alarm is scheduled or cancelled.
  BoolColumn get isScheduleOn => boolean().withDefault(const Constant(false))();

  /// Boolean denoting if to start DO NOT DISTURB mode or not when bedtime starts.
  BoolColumn get shouldStartDnd =>
      boolean().withDefault(const Constant(false))();

  /// List of app's packages which are selected as distracting apps.
  TextColumn get distractingApps => text()
      .map(const StringListConverter())
      .withDefault(Constant(jsonEncode([])))();

  
}
