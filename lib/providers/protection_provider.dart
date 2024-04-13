import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/isar/protection_model.dart';

final protectionProvider =
    StateNotifierProvider<ProtectionNotifier, ProtectionModel>((ref) {
  return ProtectionNotifier();
});

class ProtectionNotifier extends StateNotifier<ProtectionModel> {
  ProtectionNotifier() : super(const ProtectionModel()) {
    _init();
  }

  void _init() {}

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
