import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/toast_duration.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/services/shared_prefs_service.dart';
import 'package:mindful/models/isar/protection_settings.dart';

final protectionProvider =
    StateNotifierProvider<ProtectionNotifier, ProtectionSettings>((ref) {
  return ProtectionNotifier();
});

class ProtectionNotifier extends StateNotifier<ProtectionSettings> {
  ProtectionNotifier() : super(const ProtectionSettings()) {
    _init();
  }

  void _init() async {
    final cache = await IsarDbService.instance.loadProtectionSettings();

    final isAccessibilityRunning =
        await MethodChannelService.instance.isAccessibilityServiceRunning();

    final isVpnRunning =
        await MethodChannelService.instance.isVpnServiceRunning();

    state = cache.copyWith(
      appsInternetBlocker: isVpnRunning,
      websitesBlocker: cache.websitesBlocker && isAccessibilityRunning,
      blockNsfwSites: cache.blockNsfwSites,
    );

    /// Listen to provider and save changes to isar database
    addListener((state) async {
      await IsarDbService.instance.saveProtectionSettings(state);
    });
  }

  Future<void> toggleAppsInternetBlocker(bool shouldBlock) async {
    /// Show toast if no blocked apps
    if (shouldBlock && state.blockedApps.isEmpty) {
      MethodChannelService.instance.showToast(
        "Select atleast one app to block internet",
      );

      return;
    }

    bool success = false;
    if (shouldBlock) {
      /// Start vpn
      await MethodChannelService.instance.startVpnService();
      success = await MethodChannelService.instance.isVpnServiceRunning();
    } else {
      /// Stop Vpn
      success = await MethodChannelService.instance.stopVpnService();
    }

    /// Update state only if succes in starting or stopping service
    if (!success) return;
    state = state.copyWith(appsInternetBlocker: shouldBlock);
  }

  Future<void> toggleWebsitesBlocker(bool shouldBlock) async {
    /// Show toast if no blocked apps
    if (shouldBlock && state.blockedWebsites.isEmpty && !state.blockNsfwSites) {
      MethodChannelService.instance.showToast(
        "Either add atleast one distracting website or enable block nsfw sites",
        duration: ToastDuration.long,
      );

      return;
    }

    bool success = false;
    if (shouldBlock) {
      /// Start accessibility
      await MethodChannelService.instance.startAccessibilityService();
      success =
          await MethodChannelService.instance.isAccessibilityServiceRunning();
    } else {
      /// Stop accessibility
      await MethodChannelService.instance.stopAccessibilityService();
      success =
          !await MethodChannelService.instance.isAccessibilityServiceRunning();
    }

    /// Update state only if succes in starting or stopping service
    if (!success) return;
    state = state.copyWith(websitesBlocker: shouldBlock);
  }

  Future<void> toggleBlockNsfw(bool startBlocking) async {
    /// Update state
    await SharePrefsService.instance.updateNsfwBlockingStatus(startBlocking);
    state = state.copyWith(blockNsfwSites: startBlocking);
  }

  void insertRemoveBlockedApp(String appPackage, bool shouldInsert) async {
    if (shouldInsert) {
      state = state.copyWith(
        blockedApps: state.blockedApps.toList()..add(appPackage),
      );
    } else {
      state = state.copyWith(
        blockedApps: state.blockedApps.toList()..remove(appPackage),
      );
    }

    await SharePrefsService.instance.updateBlockedApps(state.blockedApps);
    await MethodChannelService.instance.flagVpnRestart();

    if (state.blockedApps.isEmpty) await toggleAppsInternetBlocker(false);
  }

  void insetRemoveBlockedSite(String websiteHost, bool shouldInsert) async {
    if (shouldInsert) {
      state = state.copyWith(
        blockedWebsites: state.blockedWebsites.toList()
          ..add(websiteHost.toLowerCase()),
      );
    } else {
      state = state.copyWith(
        blockedWebsites: state.blockedWebsites.toList()
          ..remove(websiteHost.toLowerCase()),
      );
    }

    /// This will automatically trigger update in accessibility service
    /// due to shared prefs listener is register in the service.
    await SharePrefsService.instance.updateBlockedSites(state.blockedWebsites);
  }
}
