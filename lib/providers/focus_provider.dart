import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
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
    });
  }

  Future<void> updateAppTimer(String appPackage, int timerSec) async {
    state = {...state}..update(
        appPackage,
        (value) => value.copyWith(timerSec: timerSec),
        ifAbsent: () =>
            FocusSettings(appPackage: appPackage, timerSec: timerSec),
      );

    /// Filter timers
    final appTimers = Map.fromEntries(
      state.entries
          .where((i) => i.value.timerSec > 0)
          .map((e) => MapEntry(e.key, e.value.timerSec)),
    );

    /// Refresh tracking service
    /// Timer must be refreshed before trying to stop service
    await MethodChannelService.instance.updateAppTimers(appTimers);
  }

  void switchInternetAccess(String appPackage, bool haveInternetAccess) async {
    state = {...state}..update(
        appPackage,
        (value) => value.copyWith(internetAccess: haveInternetAccess),
        ifAbsent: () => FocusSettings(
          appPackage: appPackage,
          internetAccess: haveInternetAccess,
        ),
      );

    /// start stop vpn
    final blockedApps = state.values
        .where((e) => !e.internetAccess)
        .map((e) => e.appPackage)
        .toList();

    await MethodChannelService.instance.updateBlockedApps(blockedApps);
  }
}
