import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/services/shared_prefs_service.dart';
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
    final cache = await IsarDbService.instance.loadBedtimeSettings();
    state = cache.copyWith(
      isModifiable: _isModifiable(
        cache.isScheduleOn,
        cache.startTime,
        cache.endTime,
      ),
    );

    /// Listen to provider
    addListener((state) async {
      /// Save changes to isar database
      await IsarDbService.instance.saveBedtimeSettings(state);
    });
  }

  bool _isModifiable(bool isScheduleOn, TimeOfDay startTod, TimeOfDay endTod) {
    final now = DateTime.now();
    final start = now.copyWith(hour: startTod.hour, minute: startTod.minute);
    final end = start.add(endTod.difference(startTod));

    return !isScheduleOn ||
        !_isInvincibleModeOn ||
        now.millisecondsSinceEpoch <= start.millisecondsSinceEpoch ||
        now.millisecondsSinceEpoch >= end.millisecondsSinceEpoch;
  }

  void setScheduleStatus(bool shouldStart) async {
    state = state.copyWith(isScheduleOn: shouldStart);

    // Update shared prefs
    await SharePrefsService.instance.updateBedtimeSettings(state);

    shouldStart
        ? await MethodChannelService.instance.scheduleBedtimeRoutine()
        : await MethodChannelService.instance.cancelBedtimeRoutine();
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

  void setShouldStartDnd(bool shouldStartDnd) =>
      state = state.copyWith(shouldStartDnd: shouldStartDnd);

  void insertRemoveDistractingApp(String appPackage, bool shouldInsert) async {
    if (shouldInsert) {
      state = state.copyWith(
          distractingApps: state.distractingApps.toList()..add(appPackage));
    } else {
      state = state.copyWith(
          distractingApps: state.distractingApps.toList()..remove(appPackage));

      /// Cancel schedule if no distracting apps
      if (state.distractingApps.isEmpty && state.isScheduleOn) {
        setScheduleStatus(false);
      }
    }
  }
}
