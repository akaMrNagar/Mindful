import 'package:flutter/foundation.dart';
import 'package:mindful/models/android_app.dart';

/// Responsible for aggregated data usage [screen, mobile, and wifi] of the device in the current week.
@immutable
class AggregatedUsageStatsModel {
  /// Total screen time usage of all the apps in this week as a list of int [in Seconds] for each day of week [7 days]
  final List<int> screenTimeThisWeek;

  /// Total cellular or mobile data usage of all the apps in this week as a list of int [in KBs] for each day of week [7 days]
  final List<int> mobileUsageThisWeek;

  /// Total wifi data usage of all the apps in this week as a list of int [in KBs] for each day of week [7 days]
  final List<int> wifiUsageThisWeek;

  /// Total sum of mobile and wifi data usage of all the apps in this week as a list of int [in KBs] for each day of week [7 days]
  final List<int> networkUsageThisWeek;

  const AggregatedUsageStatsModel({
    this.screenTimeThisWeek = const [0, 0, 0, 0, 0, 0, 0],
    this.mobileUsageThisWeek = const [0, 0, 0, 0, 0, 0, 0],
    this.wifiUsageThisWeek = const [0, 0, 0, 0, 0, 0, 0],
    this.networkUsageThisWeek = const [0, 0, 0, 0, 0, 0, 0],
  });

  factory AggregatedUsageStatsModel.fromApps(List<AndroidApp> apps) {
    List<int> screenTime = [];
    List<int> mobile = [];
    List<int> wifi = [];
    List<int> totalNetwork = [];

    for (var i = 0; i < 7; i++) {
      screenTime.add(apps.fold(0, (p, e) => p + e.screenTimeThisWeek[i]));
      mobile.add(apps.fold(0, (p, e) => p + e.mobileUsageThisWeek[i]));
      wifi.add(apps.fold(0, (p, e) => p + e.wifiUsageThisWeek[i]));
      totalNetwork.add(apps.fold(0, (p, e) => p + e.networkUsageThisWeek[i]));
    }
    return AggregatedUsageStatsModel(
      screenTimeThisWeek: screenTime,
      mobileUsageThisWeek: mobile,
      wifiUsageThisWeek: wifi,
      networkUsageThisWeek: totalNetwork,
    );
  }
}
