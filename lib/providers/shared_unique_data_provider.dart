/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/default_models_utils.dart';

/// A Riverpod state notifier provider that manages [SharedUniqueData].
final sharedUniqueDataProvider =
    StateNotifierProvider<SharedDataNotifier, SharedUniqueData>(
  (ref) => SharedDataNotifier(),
);

class SharedDataNotifier extends StateNotifier<SharedUniqueData> {
  SharedDataNotifier() : super(defaultSharedUniqueDataModel) {
    init();
  }

  void init() async {
    final dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await dao.loadSharedData();

    await MethodChannelService.instance.updateExcludedApps(state.excludedApps);
    await MethodChannelService.instance
        .updateDistractingNotificationApps(state.notificationBatchedApps);

    /// Run after a delay to avoid database deadlock
    /// Listen to provider and save changes to database
    Future.delayed(
      1.seconds,
      () => addListener(
        fireImmediately: false,
        (state) => dao.saveSharedData(state),
      ),
    );
  }

  /// Include or Exclude an app from total usage statistics
  void includeExcludeApp(String appPackage, bool shouldInclude) async {
    state = state.copyWith(
      excludedApps: shouldInclude
          ? [...state.excludedApps, appPackage]
          : [...state.excludedApps.where((e) => e != appPackage)],
    );

    await MethodChannelService.instance.updateExcludedApps(state.excludedApps);
  }

  /// Batch or UnBatch app from notification schedule
  void batchUnBatchApp(String appPackage, bool shouldBatch) async {
    state = state.copyWith(
      notificationBatchedApps: shouldBatch
          ? [...state.notificationBatchedApps, appPackage]
          : [...state.notificationBatchedApps.where((e) => e != appPackage)],
    );

    await MethodChannelService.instance
        .updateDistractingNotificationApps(state.notificationBatchedApps);
  }
}
