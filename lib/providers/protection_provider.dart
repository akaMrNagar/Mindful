import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    state = cache.copyWith(
      blockAppsInternet:
          await MethodChannelService.instance.isVpnServiceRunning(),
    );

    /// Listen to provider and save changes to isar database
    addListener((state) async {
      await IsarDbService.instance.saveProtectionSettings(state);
    });
  }

  Future<void> toggleBlockApps(bool startBlocking) async {
    /// Show toast if no blocked apps
    if (startBlocking && state.blockedApps.isEmpty) {
      MethodChannelService.instance.showToast(
        "Select atleast one app to block internet",
      );

      return;
    }

    bool success = false;
    if (startBlocking) {
      /// Start vpn
      await MethodChannelService.instance.startVpnService();
      success = await MethodChannelService.instance.isVpnServiceRunning();
    } else {
      /// Stop Vpn
      success = await MethodChannelService.instance.stopVpnService();
    }

    /// Update state only if succes in starting or stopping service
    if (!success) return;
    state = state.copyWith(blockAppsInternet: startBlocking);
  }

  void toggleBlockCustomWebsites() =>
      state = state.copyWith(blockCustomWebsites: !state.blockCustomWebsites);

  void toggleBlockNsfw() =>
      state = state.copyWith(blockNsfwSites: !state.blockNsfwSites);

  void addAppToBlockedList(String appPackage) async {
    state = state.copyWith(
      blockedApps: [...state.blockedApps, appPackage],
    );

    await MethodChannelService.instance.refreshVpnService();
    await SharePrefsService.instance.updateBlockedApps(state.blockedApps);
  }

  void removeAppFromBlockedList(String appPackage) async {
    state = state.copyWith(
      blockedApps: [...state.blockedApps]..remove(appPackage),
    );

    await MethodChannelService.instance.refreshVpnService();
    await SharePrefsService.instance.updateBlockedApps(state.blockedApps);
  }

  void addSiteToBlockedList(String websiteHost) => state = state.copyWith(
        blockedWebsites: [...state.blockedWebsites, websiteHost],
      );

  void removeSiteFromBlockedList(String websiteHost) => state = state.copyWith(
        blockedWebsites: [...state.blockedWebsites]..remove(websiteHost),
      );
}
