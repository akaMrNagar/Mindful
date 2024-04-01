import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/models/isar/bedtime_model.dart';

final bedtimeProvider =
    StateNotifierProvider<BedtimeNotifier, BedtimeModel>((ref) {
  return BedtimeNotifier();
});

class BedtimeNotifier extends StateNotifier<BedtimeModel> {
  BedtimeNotifier() : super(const BedtimeModel()) {
    // state = LocalStorage.instance.loadBedtimeInfo();
  }

  void toggleBedtimeScheduleStatus() {
    state = state.copyWith(scheduleStatus: !state.scheduleStatus);
    // LocalStorage.instance.saveBedtimeInfo(state);

    // if (state.bedtimeStatus) {
    //   MindfulNativePlugin.instance.scheduleBedtimeTask(info: state);
    // } else {
    //   MindfulNativePlugin.instance.cancelBedtimeTask();
    // }
  }

  void setBedtimeStart(TimeOfDay timeOfDay) =>
      state = state.copyWith(startTimeInMinutes: timeOfDay.toMinutes());

  void setBedtimeEnd(TimeOfDay timeOfDay) =>
      state = state.copyWith(endTimeInMinutes: timeOfDay.toMinutes());

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
