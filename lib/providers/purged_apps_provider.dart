import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/apps_by_screen_time_provider.dart';
import 'package:mindful/providers/device_focus_provider.dart';

final purgedAppsProvider = Provider.autoDispose<List<String>>((ref) {
  final usedApps = ref.watch(appsByScreenTimeProvider(dayOfWeek)).value;

  /// NOTE use watch.Select when adding another variable to the deviceFocusProvider model
  final timers = ref.watch(deviceFocusProvider).appsTimer;
  List<String> purgedApps = [];

  if (usedApps != null) {
    for (var app in usedApps) {
      if (timers.containsKey(app.packageName)) {
        final timer = timers[app.packageName] ?? 0;
        if (app.screenTimeThisWeek[dayOfWeek] > timer) {
          purgedApps.add(app.packageName);
        }
      }
    }
  }

  return purgedApps;
});
