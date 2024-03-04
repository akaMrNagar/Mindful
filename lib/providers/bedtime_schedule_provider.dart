import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/local_storage.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/models/bedtime_schedule_info.dart';

final bedtimeScheduleProvider =
    StateNotifierProvider<BedtimeNotifier, BedtimeScheduleInfo>((ref) {
  return BedtimeNotifier();
});

class BedtimeNotifier extends StateNotifier<BedtimeScheduleInfo> {
  BedtimeNotifier() : super(const BedtimeScheduleInfo()) {
    state = LocalStorage.instance.loadBedtimeInfo();
  }

  void toggleBedtimeStatus() {
    state = state.copyWith(bedtimeStatus: !state.bedtimeStatus);
    LocalStorage.instance.saveBedtimeInfo(state);

    // if (state.bedtimeStatus) {
    //   MindfulNativePlugin.instance.scheduleBedtimeTask(info: state);
    // } else {
    //   MindfulNativePlugin.instance.cancelBedtimeTask();
    // }
  }

  void setBedtimeStart(TimeOfDay timeOfDay) =>
      state = state.copyWith(startTime: timeOfDay);

  void setBedtimeEnd(TimeOfDay timeOfDay) =>
      state = state.copyWith(endTime: timeOfDay);

  void toggleSelectedDays(int index) {
    var days = state.selectedDays.toList();
    days[index] = !days[index];
    state = state.copyWith(selectedDays: days);
  }

  void togglePauseApps() => state = state.copyWith(pauseApps: !state.pauseApps);
  void toggleDND() => state = state.copyWith(enableDND: !state.enableDND);
}
