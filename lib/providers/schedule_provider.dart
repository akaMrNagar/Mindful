import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/schedule_info.dart';

final scheduleProvider =
    StateNotifierProvider<ScheduleNotifier, ScheduleInfo>((ref) {
  return ScheduleNotifier();
});

class ScheduleNotifier extends StateNotifier<ScheduleInfo> {
  ScheduleNotifier() : super(ScheduleInfo());

  void setScheduleStart(TimeOfDay timeOfDay) =>
      state = state.copyWith(start: timeOfDay);

  void setScheduleEnd(TimeOfDay timeOfDay) =>
      state = state.copyWith(end: timeOfDay);

  void toggleStatus() => state = state.copyWith(status: !state.status);
  void toggleDND() => state = state.copyWith(dnd: !state.dnd);
  void toggleGreyScale() => state = state.copyWith(greyScale: !state.greyScale);
  void toggleDarkTheme() => state = state.copyWith(darkTheme: !state.darkTheme);
}
