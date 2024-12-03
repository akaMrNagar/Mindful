/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */


import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'bedtime_settings.g.dart';

/// Bedtime model used for determining the actions to perform when bedtime schedule task starts.
@immutable
@collection
class BedtimeSettings {
  /// ID for isar database
  Id get id => 0;

  /// [TimeOfDay] in seconds from where the bedtime schedule task will start.
  /// It is stored as total minutes.
  final int startTimeInMins;

  /// [TimeOfDay] in seconds when the bedtime schedule task will end
  /// It is stored as total minutes.
  final int endTimeInMins;

  /// Days on which the task will execute.
  /// The list contains 7 booleans for each day of week.
  /// [TRUE] indicates that schedule task will run that day.
  /// [FALSE] indicates that schedule task will skip that day.
  final List<bool> scheduleDays;

  /// Boolean denoting the status of the bedtime schedule means
  /// [For User] if the schedule is running or not.
  /// [For Developer]  if the task worker is scheduled or cancelled.
  final bool isScheduleOn;

  /// Boolean denoting if to start DO NOT DISTURB mode or not when bedtime starts.
  final bool shouldStartDnd;

  /// List of app's packages which are selected as distracting apps.
  final List<String> distractingApps;

  /// Bedtime model used for determining the actions to perform when bedtime schedule task starts.
  const BedtimeSettings({
    this.startTimeInMins = 0,
    this.endTimeInMins = 0,
    this.scheduleDays = const [false, true, true, true, true, true, false],
    this.isScheduleOn = false,
    this.shouldStartDnd = false,
    this.distractingApps = const [],
  });
}
