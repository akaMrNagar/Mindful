import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/local_storage.dart';
import 'package:mindful/models/bedtime_info.dart';

final bedtimeProvider =
    StateNotifierProvider<BedtimeNotifier, BedtimeInfo>((ref) {
  return BedtimeNotifier();
});

class BedtimeNotifier extends StateNotifier<BedtimeInfo> {
  BedtimeNotifier() : super(const BedtimeInfo()) {
    _loadFromLocalStorage();
  }

  void _loadFromLocalStorage() =>
      state = LocalStorage.instance.loadBedtimeInfo();

  void _saveToLocalStorage() => LocalStorage.instance.saveBedtimeInfo(state);

  void setBedtimeStart(TimeOfDay timeOfDay) =>
      state = state.copyWith(startTime: timeOfDay);

  void setBedtimeEnd(TimeOfDay timeOfDay) =>
      state = state.copyWith(endTime: timeOfDay);

  void toggleSelectedDays(int index) {
    var days = state.selectedDays.toList();
    days[index] = !days[index];
    state = state.copyWith(selectedDays: days);
  }

  void toggleBedtimeStatus() =>
      state = state.copyWith(bedtimeStatus: !state.bedtimeStatus);

  void togglePauseApps() => state = state.copyWith(pauseApps: !state.pauseApps);
  void toggleDND() => state = state.copyWith(enableDND: !state.enableDND);
}
