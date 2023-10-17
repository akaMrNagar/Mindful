import 'package:flutter/foundation.dart';
import 'package:mindful/models/android_app.dart';

/// Responsible for aggregated data usage [screen, mobile, and wifi] of the device in the current week.
@immutable
class DeviceUsageInfo {
  /// Total screen time usage of all the apps in this week as a list of int [in Seconds] for each day of week [7 days]
  final List<int> deviceScreenTimeThisWeek;

  /// Total cellular or mobile data usage of all the apps in this week as a list of int [in KBs] for each day of week [7 days]
  final List<int> deviceMobileUsageThisWeek;

  /// Total wifi data usage of all the apps in this week as a list of int [in KBs] for each day of week [7 days]
  final List<int> deviceWifiUsageThisWeek;

  /// Total sum of mobile and wifi data usage of all the apps in this week as a list of int [in KBs] for each day of week [7 days]
  final List<int> deviceDataUsageThisWeek;

  const DeviceUsageInfo({
    this.deviceScreenTimeThisWeek = const [0, 0, 0, 0, 0, 0, 0],
    this.deviceMobileUsageThisWeek = const [0, 0, 0, 0, 0, 0, 0],
    this.deviceWifiUsageThisWeek = const [0, 0, 0, 0, 0, 0, 0],
    this.deviceDataUsageThisWeek = const [0, 0, 0, 0, 0, 0, 0],
  });

  factory DeviceUsageInfo.fromApps(List<AndroidApp> apps) {
    List<int> screenTime = [];
    List<int> mobile = [];
    List<int> wifi = [];
    List<int> totalData = [];

    for (var i = 0; i < 7; i++) {
      screenTime.add(apps.fold(0, (p, e) => p + e.screenTimeThisWeek[i]));
      mobile.add(apps.fold(0, (p, e) => p + e.mobileUsageThisWeek[i]));
      wifi.add(apps.fold(0, (p, e) => p + e.wifiUsageThisWeek[i]));
      totalData.add(apps.fold(0, (p, e) => p + e.dataUsageThisWeek[i]));
    }
    return DeviceUsageInfo(
      deviceScreenTimeThisWeek: screenTime,
      deviceMobileUsageThisWeek: mobile,
      deviceWifiUsageThisWeek: wifi,
      deviceDataUsageThisWeek: totalData,
    );
  }
}
