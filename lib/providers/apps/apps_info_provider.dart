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
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/app_info.dart';

/// A state notifier provider that manages a map of Package and installed Android application's info.
final appsInfoProvider =
    StateNotifierProvider<AppsInfoNotifier, AsyncValue<Map<String, AppInfo>>>(
  (ref) => AppsInfoNotifier(),
);

class AppsInfoNotifier extends StateNotifier<AsyncValue<Map<String, AppInfo>>> {
  AppsInfoNotifier() : super(const AsyncLoading()) {
    refreshAppsInfo();
  }

  /// Fetches and updates the state with the latest list of installed Android applications.
  Future<void> refreshAppsInfo() async {
    final appsList = await MethodChannelService.instance.fetchDeviceAppsInfo();

    if (mounted) {
      state = AsyncData(
        Map.fromEntries(appsList.map((e) => MapEntry(e.packageName, e))),
      );
    }
  }
}
