import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/local_storage.dart';
import 'package:mindful/models/bedtime_info.dart';

final bedtimeProvider =
    StateNotifierProvider<BedtimeNotifier, BedtimeInfo>((ref) {
  return BedtimeNotifier();
});

class BedtimeNotifier extends StateNotifier<BedtimeInfo> {
  BedtimeNotifier() : super(BedtimeInfo()) {
    _loadFromLocalStorage();
  }

  void _loadFromLocalStorage() =>
      state = LocalStorage.instance.loadBedtimeInfo();

  void _saveToLocalStorage() => LocalStorage.instance.saveBedtimeInfo(state);

  void setBedtimeStart(TimeOfDay timeOfDay) {
    state = state.copyWith(
      start: timeOfDay,
      duration: state.end.difference(timeOfDay).minutes,
    );

    _saveToLocalStorage();
  }

  void setBedtimeEnd(TimeOfDay timeOfDay) {
    state = state.copyWith(
      end: timeOfDay,
      duration: timeOfDay.difference(state.start).minutes,
    );

    _saveToLocalStorage();
  }

  void toggleSelectedDays(int index) {
    var days = state.selectedDays.toList();
    days[index] = !days[index];
    state = state.copyWith(selectedDays: days);

    _saveToLocalStorage();
  }

  void toggleBedtimeStatus() {
    state = state.copyWith(bedtimeStatus: !state.bedtimeStatus);

    _saveToLocalStorage();
  }
 
  void toggleInvincibleMode() {
    state = state.copyWith(invincible: !state.invincible);

    _saveToLocalStorage();
  }
  
  void togglePauseApps() {
    state = state.copyWith(pauseApps: !state.pauseApps);

    _saveToLocalStorage();
  }

  void toggleDND() {
    state = state.copyWith(dnd: !state.dnd);

    _saveToLocalStorage();
  }

  void toggleGreyScale() {
    state = state.copyWith(greyScale: !state.greyScale);

    _saveToLocalStorage();
  }

  void toggleDarkTheme() {
    state = state.copyWith(darkTheme: !state.darkTheme);

    _saveToLocalStorage();
  }
}
