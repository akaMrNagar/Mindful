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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/daos/unique_records_dao.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/default_models_utils.dart';

/// A Riverpod state notifier provider that manages [Wellbeing] related settings.
final wellBeingProvider = StateNotifierProvider<WellBeingNotifier, Wellbeing>(
  (ref) => WellBeingNotifier(),
);

/// This class manages the state of well-being settings.
class WellBeingNotifier extends StateNotifier<Wellbeing> {
  late UniqueRecordsDao _dao;

  WellBeingNotifier() : super(defaultWellbeingModel) {
    _init();
  }

  /// Initializes the well-being settings by loading them from the database and setting up a listener to save changes.
  void _init() async {
    _dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await _dao.loadWellBeingSettings();

    if (MethodChannelService.instance.isSelfRestart) {
      await MethodChannelService.instance.updateWellBeingSettings(state);
    }

    /// Listen to provider and save changes to Isar database and platform service
    addListener(
      fireImmediately: false,
      (state) {
        _dao.saveWellBeingSettings(state);
        MethodChannelService.instance.updateWellBeingSettings(state);
      },
    );
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

  /// Adds a website host to the nsfw websites list.
  void insertNsfwSite(String websiteHost) async => state =
      state.copyWith(nsfwWebsites: [...state.nsfwWebsites, websiteHost]);

  /// Sets the allowed time limit for short content consumption.
  void setAllowedShortContentTime(int timeSec) =>
      state = state.copyWith(allowedShortsTimeSec: timeSec > 0 ? timeSec : -1);
}
