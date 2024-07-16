import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/bedtime_settings.dart';
import 'package:mindful/providers/settings_provider.dart';

final bedtimeProvider =
    StateNotifierProvider<BedtimeNotifier, BedtimeSettings>((ref) {
  return BedtimeNotifier(
    ref.watch(settingsProvider.select((v) => v.isInvincibleModeOn)),
  );
});

class BedtimeNotifier extends StateNotifier<BedtimeSettings> {
  BedtimeNotifier(bool isInvincibleModeOn) : super(const BedtimeSettings()) {
    _isInvincibleModeOn = isInvincibleModeOn;
    _init();
  }

  bool _isInvincibleModeOn = false;

  void _init() async {
    state = await IsarDbService.instance.loadBedtimeSettings();

    /// Listen to provider
    addListener((state) async {
      /// Save changes to isar database
      await IsarDbService.instance.saveBedtimeSettings(state);
    });
  }

  bool isModifiable() {
    final startTod = state.startTime;
    final endTod = state.endTime;
    final now = DateTime.now();

    final start = now.copyWith(hour: startTod.hour, minute: startTod.minute);
    final end = start.add(endTod.difference(startTod));

    return !state.isScheduleOn ||
        !_isInvincibleModeOn ||
        now.millisecondsSinceEpoch <= start.millisecondsSinceEpoch ||
        now.millisecondsSinceEpoch >= end.millisecondsSinceEpoch;
  }

  void switchBedtimeSchedule(bool shouldStart) async {
    state = state.copyWith(isScheduleOn: shouldStart);
    await MethodChannelService.instance.updateBedtimeSchedule(state);
  }

  void setBedtimeStart(TimeOfDay startTod) =>
      state = state.copyWith(startTimeInMins: startTod.toMinutes());

  void setBedtimeEnd(TimeOfDay endTod) =>
      state = state.copyWith(endTimeInMins: endTod.toMinutes());

  void toggleScheduleDay(int index) {
    var days = state.scheduleDays.toList();
    days[index] = !days[index];
    state = state.copyWith(scheduleDays: days);
  }

  void setShouldStartDnd(bool shouldStartDnd) async {
    if (shouldStartDnd &&
        !await MethodChannelService.instance.getAndAskDndPermission()) {
      return;
    }

    state = state.copyWith(shouldStartDnd: shouldStartDnd);
  }

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
