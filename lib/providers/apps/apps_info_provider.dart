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
    AsyncNotifierProvider<AppsInfoNotifier, Map<String, AppInfo>>(() {
  return AppsInfoNotifier();
});

class AppsInfoNotifier extends AsyncNotifier<Map<String, AppInfo>> {
  @override
  Future<Map<String, AppInfo>> build() async {
    return await _fetchAppsInfo();
  }

  /// Fetches and updates the list of installed Android applications.
  Future<void> refreshAppsInfo() async =>
      state = AsyncData(await _fetchAppsInfo());

  /// Fetches installed apps info from the device.
  Future<Map<String, AppInfo>> _fetchAppsInfo() async {
    final appsList = await MethodChannelService.instance.fetchDeviceAppsInfo();
    return Map.fromEntries(appsList.map((e) => MapEntry(e.packageName, e)));
  }
}
