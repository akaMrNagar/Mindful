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
import 'package:mindful/models/android_app.dart';

/// A Riverpod state notifier provider that manages a map of Package and installed Android applications with their usage details.
final appsProvider =
    StateNotifierProvider<DeviceAppsList, AsyncValue<Map<String, AndroidApp>>>(
  (ref) => DeviceAppsList(),
);

class DeviceAppsList
    extends StateNotifier<AsyncValue<Map<String, AndroidApp>>> {
  DeviceAppsList() : super(const AsyncLoading()) {
    /// Fetches the list of installed apps and their usage data upon initialization.
    refreshDeviceApps();
  }

  /// Fetches and updates the state with the latest list of installed Android applications with their usage details.
  ///
  /// This method retrieves information about installed apps using the `MethodChannelService` and updates the internal state
  /// with a map where keys are app package names and values are corresponding `AndroidApp` objects.
  Future<bool> refreshDeviceApps() async {
    state = const AsyncLoading();
    final appsList = await MethodChannelService.instance.getDeviceApps();
    final appLaunches =
        await MethodChannelService.instance.getAppLaunchCounts();

    final cache = AsyncData(
      Map.fromEntries(
        appsList.map(
          (e) => MapEntry(
            e.packageName,
            e.copyWith(launchCount: appLaunches[e.packageName] ?? 0),
          ),
        ),
      ),
    );

    state = cache;
    return true;
  }
}
