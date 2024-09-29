/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/wellbeing_settings.dart';

/// Minimum short content time is 5 minutes.
const int minimumShortTimerSecs = 5 * 60;

/// A Riverpod state notifier provider that manages well-being related settings.
final wellBeingProvider =
    StateNotifierProvider<WellBeingNotifier, WellBeingSettings>(
  (ref) => WellBeingNotifier(),
);

/// This class manages the state of well-being settings.
class WellBeingNotifier extends StateNotifier<WellBeingSettings> {
  WellBeingNotifier() : super(const WellBeingSettings()) {
    _init();
  }

  /// Initializes the well-being settings by loading them from the database and setting up a listener to save changes.
  void _init() async {
    state = await IsarDbService.instance.loadWellBeingSettings();

    /// Update timer if it is less than minimum time
    if (state.allowedShortContentTimeSec < minimumShortTimerSecs) {
      setAllowedShortContentTime(minimumShortTimerSecs);
    }

    /// Listen to provider and save changes to Isar database and platform service
    addListener((state) async {
      await IsarDbService.instance.saveWellBeingSettings(state);
      await MethodChannelService.instance.updateWellBeingSettings(state);
    });
  }

  /// Toggles the block status for Instagram Reels.
  void switchBlockInstaReels() =>
      state = state.copyWith(blockInstaReels: !state.blockInstaReels);

  /// Toggles the block status for YouTube Shorts.
  void switchBlockYtShorts() =>
      state = state.copyWith(blockYtShorts: !state.blockYtShorts);

  /// Toggles the block status for Snapchat Spotlight.
  void switchBlockSnapSpotlight() =>
      state = state.copyWith(blockSnapSpotlight: !state.blockSnapSpotlight);

  /// Toggles the block status for Facebook Reels.
  void switchBlockFbReels() =>
      state = state.copyWith(blockFbReels: !state.blockFbReels);

  /// Toggles the block status for Reddit Shorts.
  void switchBlockRedditShorts() =>
      state = state.copyWith(blockRedditShorts: !state.blockRedditShorts);

  /// Toggles the block status for NSFW websites.
  void switchBlockNsfwSites() =>
      state = state.copyWith(blockNsfwSites: !state.blockNsfwSites);

  /// Adds or removes a website host to the blocked websites list.
  void insertRemoveBlockedSite(String websiteHost, bool shouldInsert) async =>
      state = state.copyWith(
        blockedWebsites: shouldInsert
            ? [...state.blockedWebsites, websiteHost]
            : [...state.blockedWebsites.where((e) => e != websiteHost)],
      );

  /// Sets the allowed time limit for short content consumption.
  void setAllowedShortContentTime(int timeSec) =>
      state = state.copyWith(allowedShortContentTimeSec: timeSec);
}
