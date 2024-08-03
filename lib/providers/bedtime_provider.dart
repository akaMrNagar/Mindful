import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/bedtime_settings.dart';

/// A Riverpod state notifier provider that manages Bedtime settings including schedule, Do Not Disturb, and distracting apps.
final bedtimeProvider = StateNotifierProvider<BedtimeNotifier, BedtimeSettings>(
  (ref) => BedtimeNotifier(),
);

class BedtimeNotifier extends StateNotifier<BedtimeSettings> {
  BedtimeNotifier() : super(const BedtimeSettings()) {
    _init();
  }

  /// Initializes the Bedtime state by loading settings from the database and setting up a listener to save changes back.
  void _init() async {
    state = await IsarDbService.instance.loadBedtimeSettings();
    addListener((state) async {
      /// Save changes to the Isar database whenever the state updates.
      await IsarDbService.instance.saveBedtimeSettings(state);
    });
  }

  /// Determines whether the Bedtime schedule can be modified based on current time, Invincible Mode, and schedule state.
  bool isModifiable(bool isInvincibleModeOn) {
    final startTod = state.startTime;
    final endTod = state.endTime;
    final now = DateTime.now();

    /// Calculate start and end time based on schedule
    final start = now.copyWith(hour: startTod.hour, minute: startTod.minute);
    final end = start.add(endTod.difference(startTod));

    return !state.isScheduleOn ||
        !isInvincibleModeOn ||
        now.isBefore(start) ||
        now.isAfter(end);
  }

  /// Enables or disables the Bedtime schedule.
  void switchBedtimeSchedule(bool shouldStart) async {
    state = state.copyWith(isScheduleOn: shouldStart);
    await MethodChannelService.instance.updateBedtimeSchedule(state);
  }

  /// Sets the start time of the Bedtime schedule using TimeOfDay minutes.
  void setBedtimeStart(TimeOfDay startTod) =>
      state = state.copyWith(startTimeInMins: startTod.minutes);

  /// Sets the end time of the Bedtime schedule using TimeOfDay minutes.
  void setBedtimeEnd(TimeOfDay endTod) =>
      state = state.copyWith(endTimeInMins: endTod.minutes);

  /// Toggles the scheduled day for a specific day index.
  void toggleScheduleDay(int index) {
    var days = state.scheduleDays.toList();
    days[index] = !days[index];
    state = state.copyWith(scheduleDays: days);
  }

  /// Enables or disables Do Not Disturb during the Bedtime schedule.
  ///
  /// Checks for Do Not Disturb permission before enabling it.
  void setShouldStartDnd(bool shouldStartDnd) async {
    if (shouldStartDnd &&
        !await MethodChannelService.instance.getAndAskDndPermission()) {
      return;
    }
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
