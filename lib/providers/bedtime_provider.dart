import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/models/isar/bedtime_settings.dart';

final bedtimeProvider =
    StateNotifierProvider<BedtimeNotifier, BedtimeSettings>((ref) {
  return BedtimeNotifier();
});

class BedtimeNotifier extends StateNotifier<BedtimeSettings> {
  BedtimeNotifier() : super(const BedtimeSettings()) {
    _init();
  }

  void _init() async {
    state = await IsarDbService.instance.loadBedtimeSettings();

    /// Listen to provider and save changes to isar database
    addListener((state) async {
      await IsarDbService.instance.saveBedtimeSettings(state);
    });
  }

  void toggleBedtimeScheduleStatus() =>
      state = state.copyWith(scheduleStatus: !state.scheduleStatus);

  void setBedtimeStart(TimeOfDay timeOfDay) =>
      state = state.copyWith(startTimeInSec: timeOfDay.toSeconds());

  void setBedtimeEnd(TimeOfDay timeOfDay) =>
      state = state.copyWith(endTimeInSec: timeOfDay.toSeconds());

  void toggleScheduleDays(int index) {
    var days = state.scheduleDays.toList();
    days[index] = !days[index];
    state = state.copyWith(scheduleDays: days);
  }

  void toggleScreenLockdown() =>
      state = state.copyWith(startScreenLockdown: !state.startScreenLockdown);

  void toggleInternetLockdown() => state =
      state.copyWith(startInternetLockdown: !state.startInternetLockdown);

  void toggleDND() => state = state.copyWith(startDnd: !state.startDnd);

  void addDistractionApp(String appPackage) => state = state.copyWith(
      distractionApps: state.distractionApps.toList()..add(appPackage));

  void removeDistractionApp(String appPackage) => state = state.copyWith(
      distractionApps: state.distractionApps.toList()..remove(appPackage));
}
