import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/shared_prefs_service.dart';
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
      // Update shared prefs
      await SharePrefsService.instance.updateBedtimeSettings(state);
    });
  }

  void toggleScheduleStatus() =>
      state = state.copyWith(isScheduleOn: !state.isScheduleOn);

  void setBedtimeStart(TimeOfDay timeOfDay) =>
      state = state.copyWith(startTimeInSec: timeOfDay.toSeconds());

  void setBedtimeEnd(TimeOfDay timeOfDay) =>
      state = state.copyWith(endTimeInSec: timeOfDay.toSeconds());

  void toggleScheduleDay(int index) {
    var days = state.scheduleDays.toList();
    days[index] = !days[index];
    state = state.copyWith(scheduleDays: days);
  }

  void toggleShouldPauseApps() =>
      state = state.copyWith(shouldPauseApps: !state.shouldPauseApps);

  void toggleShouldBlockInternet() =>
      state = state.copyWith(shouldBlockInternet: !state.shouldBlockInternet);

  void toggleShouldStartDnd() =>
      state = state.copyWith(shouldStartDnd: !state.shouldStartDnd);

  void insertRemoveDistractingApp(String appPackage, bool shouldInsert) async {
    if (shouldInsert) {
      state = state.copyWith(
          distractingApps: state.distractingApps.toList()..add(appPackage));
    } else {
      state = state.copyWith(
          distractingApps: state.distractingApps.toList()..remove(appPackage));
    }
  }
}
