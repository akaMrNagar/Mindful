import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/bedtime_info.dart';

final bedtimeProvider =
    StateNotifierProvider<BedtimeNotifier, BedtimeInfo>((ref) {
  return BedtimeNotifier();
});

class BedtimeNotifier extends StateNotifier<BedtimeInfo> {
  BedtimeNotifier() : super(BedtimeInfo());

  void setBedtimeStart(TimeOfDay timeOfDay) =>
      state = state.copyWith(start: timeOfDay);

  void setBedtimeEnd(TimeOfDay timeOfDay) =>
      state = state.copyWith(end: timeOfDay);

  void toggleSelectedDays(int index) {
    var days = state.selectedDays.toList();
    days[index] = !days[index];
    state = state.copyWith(selectedDays: days);
  }

  void toggleBedtimeStatus() => state = state.copyWith(bedtimeStatus: !state.bedtimeStatus);
  void toggleDND() => state = state.copyWith(dnd: !state.dnd);
  void toggleGreyScale() => state = state.copyWith(greyScale: !state.greyScale);
  void toggleDarkTheme() => state = state.copyWith(darkTheme: !state.darkTheme);
}
