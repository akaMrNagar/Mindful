import 'package:flutter/foundation.dart';
import 'package:mindful/models/android_app.dart';

@immutable
class DeviceUsageInfo {
  final List<int> deviceScreenTimeThisWeek;
  // int get deviceScreenTimeToday => deviceScreenTimeThisWeek[dayOfWeek];

  final List<int> deviceMobileUsageThisWeek;
  // int get deviceMobileUsageToday => deviceMobileUsageThisWeek[dayOfWeek];

  final List<int> deviceWifiUsageThisWeek;
  // int get deviceWifiUsageToday => deviceWifiUsageThisWeek[dayOfWeek];

  /// Total sum of wifi+mobile
  final List<int> deviceDataUsageThisWeek;
  // int get deviceDataUsageToday => deviceDataUsageThisWeek[dayOfWeek];

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
