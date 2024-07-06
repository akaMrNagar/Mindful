import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/services/shared_prefs_service.dart';
import 'package:mindful/models/isar/wellbeing_settings.dart';

final wellbeingProvider =
    StateNotifierProvider<WellbeingNotifier, WellbeingSettings>((ref) {
  return WellbeingNotifier();
});

class WellbeingNotifier extends StateNotifier<WellbeingSettings> {
  WellbeingNotifier() : super(const WellbeingSettings()) {
    _init();
  }

  void _init() async {
    final cache = await IsarDbService.instance.loadWellbeingSettings();

    final isAccessibilityRunning =
        await MethodChannelService.instance.isAccessibilityServiceRunning();

    final isVpnRunning =
        await MethodChannelService.instance.isVpnServiceRunning();

    state = cache.copyWith(
      isInternetBlockerOn: isVpnRunning,
      isDistractionBlockerOn: isAccessibilityRunning,
    );

    /// Listen to provider and save changes to isar database
    addListener(
      (state) async =>
          await IsarDbService.instance.saveWellbeingSettings(state),
    );
  }

  ///
  // ********************************** Internet Blocker *************************************************
  ///

  Future<void> switchInternetBlocker(bool shouldBlock) async {
    /// Start/Stop vpn service
    shouldBlock
        ? await MethodChannelService.instance.startVpnService()
        : await MethodChannelService.instance.stopVpnService();

    final success = await MethodChannelService.instance.isVpnServiceRunning();

    /// Update state only if succes in starting or stopping service
    if (success != shouldBlock) return;
    state = state.copyWith(isInternetBlockerOn: shouldBlock);
  }

  void insertRemoveBlockedApp(String appPackage, bool shouldInsert) async {
    state = state.copyWith(
      blockedApps: shouldInsert
          ? [...state.blockedApps, appPackage]
          : [...state.blockedApps.where((e) => e != appPackage)],
    );

    await SharePrefsService.instance.updateBlockedApps(state.blockedApps);
    await MethodChannelService.instance.flagVpnRestart();

    /// Turn OFF internet blocker if no distraction app selected
    if (state.blockedApps.isEmpty) await switchInternetBlocker(false);
  }

  ///
  // ********************************** Distraction Blocker *************************************************
  ///

  Future<void> switchDistractionBlocker(bool shouldBlock) async {
    await SharePrefsService.instance.updateIsDistractionBlockerOn(shouldBlock);

    /// Start/Stop accessibility
    if (shouldBlock) {
      await MethodChannelService.instance.startAccessibilityService();
    }

    final isServiceRunning =
        await MethodChannelService.instance.isAccessibilityServiceRunning();

    /// Update state only if succes in starting or stopping service
    if (isServiceRunning != shouldBlock) return;
    state = state.copyWith(isDistractionBlockerOn: shouldBlock);
  }

  void switchBlockNsfw(bool shouldBlock) async {
    await SharePrefsService.instance.updateShouldBlockNsfw(shouldBlock);
    state = state.copyWith(blockNsfwSites: shouldBlock);
  }

  void switchBlockShortContent(bool shouldBlock) async {
    await SharePrefsService.instance.updateShouldBlockShorts(shouldBlock);
    state = state.copyWith(blockShortContent: shouldBlock);
  }

  void insertRemoveBlockedSite(String websiteHost, bool shouldInsert) async {
    state = state.copyWith(
      blockedWebsites: shouldInsert
          ? [...state.blockedWebsites, websiteHost]
          : [...state.blockedWebsites.where((e) => e != websiteHost)],
    );

    await SharePrefsService.instance
        .updateBlockedWebsites(state.blockedWebsites);
  }
}
