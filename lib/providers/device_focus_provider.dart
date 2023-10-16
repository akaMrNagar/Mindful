import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/local_storage.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/models/device_focus_info.dart';

/// Apps Timer time in minutes
final deviceFocusProvider =
    StateNotifierProvider<DeviceFocus, DeviceFocusInfo>((ref) {
  return DeviceFocus();
});

///TODO: update databade onDestroy and also add autodispose to provider
class DeviceFocus extends StateNotifier<DeviceFocusInfo> {
  DeviceFocus() : super(const DeviceFocusInfo(appsTimer: {})) {
    _init();
  }

  void _init() async {
    state = state.copyWith(
      appsTimer: await LocalStorage.instance.loadAppTimers(),
    );
  }

  Future<void> appendAppTimer(String packageName, int timer) async {
    if (timer > 0) {
      state = state.copyWith(
        appsTimer: state.appsTimer.map((key, value) => MapEntry(key, value))
          ..update(packageName, (value) => timer, ifAbsent: () => timer),
      );
    } else {
      /// remove entry
      state = state.copyWith(appsTimer: state.appsTimer..remove(packageName));
    }

    await LocalStorage.instance.saveAppTimers(state.appsTimer);
    MindfulNativePlugin.instance.restartTrackingService();
  }
}
