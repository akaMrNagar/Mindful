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
import 'package:mindful/models/isar/restriction_info.dart';

/// A Riverpod state notifier provider that manages focus settings for individual apps, including timers and internet access.
final restrictionInfosProvider =
    StateNotifierProvider<RestrictionInfos, Map<String, RestrictionInfo>>(
  (ref) => RestrictionInfos(),
);

class RestrictionInfos extends StateNotifier<Map<String, RestrictionInfo>> {
  RestrictionInfos() : super({}) {
    _init();
  }

  /// Initializes the infos state by loading data from the Isar database and setting up a listener to save changes back.
  void _init() async {
    final items = await IsarDbService.instance.loadRestrictionInfos();
    state = Map.fromEntries(items.map((e) => MapEntry(e.appPackage, e)));

    addListener((state) async {
      /// Save changes to the Isar database whenever the state updates.
      await IsarDbService.instance.saveRestrictionInfos(state.values.toList());
    });
  }

  /// Updates the focus timer for a specific app package if package is not empty.
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateAppTimer(String appPackage, int timerSec) async {
    if (appPackage.isNotEmpty) {
      state = {...state}..update(
          appPackage,
          (value) => value.copyWith(timerSec: timerSec),
          ifAbsent: () =>
              RestrictionInfo(appPackage: appPackage, timerSec: timerSec),
        );
    }

    final appTimers = Map.fromEntries(
      state.entries
          .where((i) => i.value.timerSec > 0)
          .map((e) => MapEntry(e.key, e.value.timerSec)),
    );

    /// Refresh tracking service
    /// Timer must be refreshed before trying to stop service
    await MethodChannelService.instance.updateAppTimers(appTimers);
  }

  /// Toggles internet access permission for a specific app package if package is not empty.
  ///
  /// Anyway call the platform channel service to potentially start or stop a VPN.
  void switchInternetAccess(String appPackage, bool haveInternetAccess) async {
    if (appPackage.isNotEmpty) {
      state = {...state}..update(
          appPackage,
          (value) => value.copyWith(internetAccess: haveInternetAccess),
          ifAbsent: () => RestrictionInfo(
            appPackage: appPackage,
            internetAccess: haveInternetAccess,
          ),
        );
    }

    final blockedApps = state.values
        .where((e) => !e.internetAccess)
        .map((e) => e.appPackage)
        .toList();

    await MethodChannelService.instance.updateBlockedApps(blockedApps);
  }

  /// Restart services if they ara inactive but needed
  void checkAndRestartServices({
    required bool haveVpnPermission,
  }) {
    /// Calling these methods with empty package to only start services if they are needed but they are inactive
    updateAppTimer('', 0);
    if (haveVpnPermission) switchInternetAccess('', true);
  }
}
