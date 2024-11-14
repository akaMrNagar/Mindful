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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/tables/bedtime_schedule_table.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';

/// A Riverpod state notifier provider that manages [BedtimeSchedule].
final bedtimeScheduleProvider =
    StateNotifierProvider<BedtimeScheduleNotifier, BedtimeSchedule>(
  (ref) => BedtimeScheduleNotifier(),
);

class BedtimeScheduleNotifier extends StateNotifier<BedtimeSchedule> {
  BedtimeScheduleNotifier()
      : super(BedtimeScheduleTable.defaultBedtimeScheduleModel) {
    _init();
  }

  /// Initializes the Bedtime state by loading settings from the database and setting up a listener to save changes back.
  void _init() async {
    final dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await dao.loadBedtimeSchedule();

    /// Save changes to the database whenever the state updates.
    addListener(
      fireImmediately: false,
      (state) => dao.saveBedtimeSchedule(state),
    );
  }

  /// Enables or disables the Bedtime schedule.
  void switchBedtimeSchedule(bool shouldStart) async {
    state = state.copyWith(isScheduleOn: shouldStart);
    await MethodChannelService.instance.updateBedtimeSchedule(state);
  }

  /// Sets the start time of the Bedtime schedule using TimeOfDay minutes.
  void setBedtimeStart(TimeOfDay startTod) => state = state.copyWith(
        startTimeInMins: startTod.minutes,
        totalDurationInMins:
            state.endTimeInMins.toTimeOfDay.difference(startTod).inMinutes,
      );

  /// Sets the end time of the Bedtime schedule using TimeOfDay minutes.
  void setBedtimeEnd(TimeOfDay endTod) => state = state.copyWith(
        endTimeInMins: endTod.minutes,
        totalDurationInMins:
            endTod.difference(state.startTimeInMins.toTimeOfDay).inMinutes,
      );

  /// Toggles the scheduled day for a specific day index.
  void toggleScheduleDay(int index) {
    var days = state.scheduleDays.toList();
    days[index] = !days[index];
    state = state.copyWith(scheduleDays: days);
  }

  /// Enables or disables Do Not Disturb during the Bedtime schedule.
  void setShouldStartDnd(bool shouldStartDnd) async {
    state = state.copyWith(shouldStartDnd: shouldStartDnd);
  }

  /// Adds or removes an app package from the list of distracting apps.
  ///
  /// If no distracting apps remain after removal and the schedule is active, it cancels the schedule.
  void insertRemoveDistractingApp(String appPackage, bool shouldInsert) async {
    state = state.copyWith(
      distractingApps: shouldInsert
          ? [...state.distractingApps, appPackage]
          : [...state.distractingApps.where((e) => e != appPackage)],
    );

    /// Cancel schedule if no distracting apps
    if (!shouldInsert && state.distractingApps.isEmpty && state.isScheduleOn) {
      switchBedtimeSchedule(false);
    }
  }
}
