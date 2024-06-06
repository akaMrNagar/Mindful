import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/services/shared_prefs_service.dart';
import 'package:mindful/models/isar/focus_settings.dart';

final focusProvider =
    StateNotifierProvider<AppFocusInfos, Map<String, FocusSettings>>((ref) {
  return AppFocusInfos();
});

class AppFocusInfos extends StateNotifier<Map<String, FocusSettings>> {
  AppFocusInfos() : super({}) {
    _init();
  }

  void _init() async {
    final items = await IsarDbService.instance.loadFocusSettings();
    state = Map.fromEntries(items.map((e) => MapEntry(e.appPackage, e)));

    /// Listen to provider
    addListener((state) async {
      /// save changes to isar database
      await IsarDbService.instance.saveFocusSettings(state.values.toList());

      /// Refresh service
      MethodChannelService.instance.refreshTrackerService();
    });
  }

  Future<void> updateAppTimer(String appPackage, int timerSec) async {
    state = {...state}..update(
        appPackage,
        (value) => value.copyWith(timer: timerSec),
        ifAbsent: () => FocusSettings(appPackage: appPackage, timer: timerSec),
      );

    /// Filter timers
    final appTimers = Map.fromEntries(
      state.entries.where((element) => element.value.timer > 0).map(
            (e) => MapEntry(e.key, e.value.timer),
          ),
    );

    /// Update shared pref app timers
    SharePrefsService.instance.updateAppTimers(appTimers);
  }
}
