import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/shared_prefs_service.dart';
import 'package:mindful/models/isar/wellbeing_settings.dart';

final wellBeingProvider =
    StateNotifierProvider<WellBeingNotifier, WellBeingSettings>((ref) {
  return WellBeingNotifier();
});

class WellBeingNotifier extends StateNotifier<WellBeingSettings> {
  WellBeingNotifier() : super(const WellBeingSettings()) {
    _init();
  }

  void _init() async {
    state = await IsarDbService.instance.loadWellBeingSettings();

    /// Listen to provider and save changes to isar database
    addListener((state) async {
      await IsarDbService.instance.saveWellBeingSettings(state);
      await SharePrefsService.instance.updateWellBeingSettings(state);
    });
  }

  void switchBlockInstaReels() =>
      state = state.copyWith(blockInstaReels: !state.blockInstaReels);

  void switchBlockYtShorts() =>
      state = state.copyWith(blockYtShorts: !state.blockYtShorts);

  void switchBlockSnapSpotlight() =>
      state = state.copyWith(blockSnapSpotlight: !state.blockSnapSpotlight);

  void switchBlockFbReels() =>
      state = state.copyWith(blockFbReels: !state.blockFbReels);

  void switchBlockNsfwSites() =>
      state = state.copyWith(blockNsfwSites: !state.blockNsfwSites);

  void insertRemoveBlockedSite(String websiteHost, bool shouldInsert) async =>
      state = state.copyWith(
        blockedWebsites: shouldInsert
            ? [...state.blockedWebsites, websiteHost]
            : [...state.blockedWebsites.where((e) => e != websiteHost)],
      );
}


  // void insertRemoveBlockedApp(String appPackage, bool shouldInsert) async {
  //   state = state.copyWith(
  //     blockedApps: shouldInsert
  //         ? [...state.blockedApps, appPackage]
  //         : [...state.blockedApps.where((e) => e != appPackage)],
  //   );

  //   await SharePrefsService.instance.updateBlockedApps(state.blockedApps);
  //   await MethodChannelService.instance.flagVpnRestart();

  //   /// Turn OFF internet blocker if no distraction app selected
  //   if (state.blockedApps.isEmpty) await switchInternetBlocker(false);
  // }
