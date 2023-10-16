import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/models/android_app.dart';

final appsProvider =
    StateNotifierProvider<DeviceAppsList, AsyncValue<List<AndroidApp>>>((ref) {
  return DeviceAppsList();
});

class DeviceAppsList extends StateNotifier<AsyncValue<List<AndroidApp>>> {
  DeviceAppsList() : super(const AsyncValue.loading()) {
    /// inititalization
    refreshDeviceApps();
  }

  Future<bool> refreshDeviceApps() async {
    await MindfulNativePlugin.instance
        .getDeviceApps()
        .then((value) => state = AsyncData(value));
    return true;
  }
}
