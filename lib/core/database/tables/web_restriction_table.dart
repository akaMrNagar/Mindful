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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/reminder_type.dart';

@DataClassName("WebRestriction")
class WebRestrictionTable extends Table {
  /// host for website
  TextColumn get host => text()();

  @override
  Set<Column<Object>>? get primaryKey => {host};

  /// The timer set for the app in SECONDS
  IntColumn get timerSec => integer().withDefault(const Constant(0))();

  /// The number of times user can launch the website
  IntColumn get launchLimit => integer().withDefault(const Constant(0))();

  /// [TimeOfDay] in minutes from where the active period will start.
  /// It is stored as total minutes.
  IntColumn get activePeriodStart => integer()
      .map(const TimeOfDayAdapterConverter())
      .withDefault(const Constant(0))();

  /// [TimeOfDay] in minutes when the active period will end
  /// It is stored as total minutes.
  IntColumn get activePeriodEnd => integer()
      .map(const TimeOfDayAdapterConverter())
      .withDefault(const Constant(0))();

  /// Total duration of active period from start to end in MINUTES
  IntColumn get periodDurationInMins =>
      integer().withDefault(const Constant(0))();

  /// ID of the [RestrictionGroup] this app is associated with or NULL
  IntColumn get associatedGroupId =>
      integer().nullable().withDefault(const Constant(null))();

  /// Flag denoting if this website is nsfw
  BoolColumn get isNsfw =>
      boolean().withDefault(const Constant(false))();

  /// [ReminderType] Type of reminders to show when using timed app
  TextColumn get reminderType =>
      textEnum<ReminderType>().withDefault(Constant(ReminderType.toast.name))();
}
