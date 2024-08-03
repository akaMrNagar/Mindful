import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/focus_settings.dart';

/// A Riverpod state notifier provider that manages focus settings for individual apps, including timers and internet access.
final focusProvider =
    StateNotifierProvider<AppFocusInfos, Map<String, FocusSettings>>(
  (ref) => AppFocusInfos(),
);

class AppFocusInfos extends StateNotifier<Map<String, FocusSettings>> {
  AppFocusInfos() : super({}) {
    _init();
  }

  /// Initializes the focus settings state by loading data from the Isar database and setting up a listener to save changes back.
  void _init() async {
    final items = await IsarDbService.instance.loadFocusSettings();
    state = Map.fromEntries(items.map((e) => MapEntry(e.appPackage, e)));

    addListener((state) async {
      /// Save changes to the Isar database whenever the state updates.
      await IsarDbService.instance.saveFocusSettings(state.values.toList());
    });
  }

  /// Updates the focus timer for a specific app package.
  ///
  /// Also filters timers, updates the platform-specific service, and saves changes to the database.
  Future<void> updateAppTimer(String appPackage, int timerSec) async {
    state = {...state}..update(
        appPackage,
        (value) => value.copyWith(timerSec: timerSec),
        ifAbsent: () =>
            FocusSettings(appPackage: appPackage, timerSec: timerSec),
      );

    final appTimers = Map.fromEntries(
      state.entries
          .where((i) => i.value.timerSec > 0)
          .map((e) => MapEntry(e.key, e.value.timerSec)),
    );

    /// Refresh tracking service
    /// Timer must be refreshed before trying to stop service
    await MethodChannelService.instance.updateAppTimers(appTimers);
  }

  /// Toggles internet access permission for a specific app package.
  ///
  /// Updates the focus settings and calls the platform channel service to potentially start or stop a VPN.
  void switchInternetAccess(String appPackage, bool haveInternetAccess) async {
    state = {...state}..update(
        appPackage,
        (value) => value.copyWith(internetAccess: haveInternetAccess),
        ifAbsent: () => FocusSettings(
          appPackage: appPackage,
          internetAccess: haveInternetAccess,
        ),
      );

    final blockedApps = state.values
        .where((e) => !e.internetAccess)
        .map((e) => e.appPackage)
        .toList();

    await MethodChannelService.instance.updateBlockedApps(blockedApps);
  }
}
