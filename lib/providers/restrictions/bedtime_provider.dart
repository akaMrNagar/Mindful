/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/default_models_utils.dart';

/// A Riverpod state notifier provider that manages [BedtimeSchedule].
final bedtimeScheduleProvider =
    StateNotifierProvider<BedtimeScheduleNotifier, BedtimeSchedule>(
  (ref) => BedtimeScheduleNotifier(),
);

class BedtimeScheduleNotifier extends StateNotifier<BedtimeSchedule> {
  /// Returns `TRUE` if the time now is between the bedtime schedule otherwise `FALSE`.
  bool get isBetweenSchedule => DateTime.now().isBetweenTod(
        state.scheduleStartTime,
        state.scheduleEndTime,
      );

  BedtimeScheduleNotifier() : super(defaultBedtimeScheduleModel) {
    _init();
  }

  /// Initializes the Bedtime state by loading settings from the database and setting up a listener to save changes back.
  void _init() async {
    final dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await dao.loadBedtimeSchedule();

    if (MethodChannelService.instance.isSelfRestart) {
      if (state.isScheduleOn &&
          state.distractingApps.isNotEmpty &&
          state.scheduleDurationInMins >= 30) {
        await MethodChannelService.instance.updateBedtimeSchedule(state);
      } else {
        state = state.copyWith(isScheduleOn: false);
      }
    }

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
  void setBedtimeStart(TimeOfDayAdapter startTime) => state = state.copyWith(
        scheduleStartTime: startTime,
        scheduleDurationInMins:
            state.scheduleEndTime.difference(startTime).inMinutes,
      );

  /// Sets the end time of the Bedtime schedule using TimeOfDay minutes.
  void setBedtimeEnd(TimeOfDayAdapter endTime) => state = state.copyWith(
        scheduleEndTime: endTime,
        scheduleDurationInMins:
            endTime.difference(state.scheduleStartTime).inMinutes,
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
