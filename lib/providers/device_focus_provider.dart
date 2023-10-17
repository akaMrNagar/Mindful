import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/local_storage.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/models/device_focus_info.dart';

/// Provides information and data related to device or app focus plans
final deviceFocusProvider =
    StateNotifierProvider<DeviceFocus, DeviceFocusInfo>((ref) {
  return DeviceFocus();
});

/// NOTE Modify the purgedAppsProvider to watch selection if the base class grows in future
class DeviceFocus extends StateNotifier<DeviceFocusInfo> {
  DeviceFocus() : super(const DeviceFocusInfo()) {
    _init();
  }

  void _init() async {
    state = state.copyWith(
      appsTimer: await LocalStorage.instance.loadAppTimers(),
    );
  }

  /// Add app timer to timers map also removes timer from map if the timer is 0
  /// After adding timer to map it also updates the shared pref and
  /// restart the foreground service
  Future<void> appendAppTimer(String packageName, int timer) async {
    if (timer > 0) {
      state = state.copyWith(
        appsTimer: state.appsTimer.map((key, value) => MapEntry(key, value))
          ..update(packageName, (value) => timer, ifAbsent: () => timer),
      );
    } else {
      /// remove entry
      state = state.copyWith(
        appsTimer: state.appsTimer..remove(packageName),
      );
    }

    await LocalStorage.instance.saveAppTimers(state.appsTimer);
    MindfulNativePlugin.instance.restartTrackingService();
  }
}
