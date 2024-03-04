import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/local_storage.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/models/app_focus_info.dart';

final appFocusInfosProvider =
    StateNotifierProvider<AppFocusInfos, Map<String, AppFocusInfo>>((ref) {
  return AppFocusInfos();
});

class AppFocusInfos extends StateNotifier<Map<String, AppFocusInfo>> {
  AppFocusInfos() : super({}) {
    state = LocalStorage.instance.loadAppFocusInfos();
  }

  Future<bool> setAppTimer(String appPackage, int timer) async {
    var newState = Map<String, AppFocusInfo>.from(state);

    if (timer <= 0) {
      newState.remove(appPackage);
    } else {
      newState.update(
        appPackage,
        (value) => value.copyWith(timer: timer),
        ifAbsent: () => AppFocusInfo(timer: timer),
      );
    }

    state = newState;

    LocalStorage.instance.saveAppFocusInfos(state);
    MindfulNativePlugin.instance.refreshAppTimers();
    return true;
  }
}
