import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/isar/focus_model.dart';

final focusProvider =
    StateNotifierProvider<AppFocusInfos, Map<String, FocusModel>>((ref) {
  return AppFocusInfos();
});

class AppFocusInfos extends StateNotifier<Map<String, FocusModel>> {
  AppFocusInfos() : super({}) {
    // state = LocalStorage.instance.loadAppFocusInfos();
  }

  Future<bool> setAppTimer(String appPackage, int timerSec) async {
    // var newState = Map<String, AppFocusInfo>.from(state);

    // if (timer <= 0) {
    //   newState.remove(appPackage);
    // } else {
    //   newState.update(
    //     appPackage,
    //     (value) => value.copyWith(timer: timer),
    //     ifAbsent: () => AppFocusInfo(timer: timer),
    //   );
    // }

    // state = newState;

    // LocalStorage.instance.saveAppFocusInfos(state);
    // MethodChannelService.instance.refreshAppTimers();
    return true;
  }
}
