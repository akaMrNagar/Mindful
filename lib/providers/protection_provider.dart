import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
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
    state = await IsarDbService.instance.loadProtectionSettings();

    /// Listen to provider and save changes to isar database
    addListener((state) async {
      await IsarDbService.instance.saveProtectionSettings(state);
    });
  }

  void toggleBlockApps() =>
      state = state.copyWith(blockAppsInternet: !state.blockAppsInternet);

  void toggleBlockCustomWebsites() =>
      state = state.copyWith(blockCustomWebsites: !state.blockCustomWebsites);

  void toggleBlockNsfw() =>
      state = state.copyWith(blockNsfwSites: !state.blockNsfwSites);

  void addAppToBlockedList(String appPackage) => state = state.copyWith(
        blockedApps: [...state.blockedApps, appPackage],
      );

  void removeAppFromBlockedList(String appPackage) => state = state.copyWith(
        blockedApps: [...state.blockedApps]..remove(appPackage),
      );

  void addSiteToBlockedList(String websiteHost) => state = state.copyWith(
        blockedWebsites: [...state.blockedWebsites, websiteHost],
      );

  void removeSiteFromBlockedList(String websiteHost) => state = state.copyWith(
        blockedWebsites: [...state.blockedWebsites]..remove(websiteHost),
      );
}
