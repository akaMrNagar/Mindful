import 'package:flutter/foundation.dart';

import 'package:mindful/core/database/app_database.dart';


@immutable
class UsageModel {
  /// Screen time in SECONDS
  final int screenTime;

  /// Mobile data usage in KBs
  final int mobileData;

  /// Wifi data usage in KBs
  final int wifiData;

  /// Total data usage including mobile and wifi in KBs
  int get totalData => mobileData + wifiData;

  const UsageModel({
    this.screenTime = 0,
    this.mobileData = 0,
    this.wifiData = 0,
  });

  factory UsageModel.fromAppUsage(AppUsage appUsage) {
    return UsageModel(
      screenTime: appUsage.screenTime,
      mobileData: appUsage.mobileData,
      wifiData: appUsage.mobileData,
    );
  }

  UsageModel copyWith({
    int? screenTime,
    int? mobileData,
    int? wifiData,
  }) {
    return UsageModel(
      screenTime: screenTime ?? this.screenTime,
      mobileData: mobileData ?? this.mobileData,
      wifiData: wifiData ?? this.wifiData,
    );
  }

  UsageModel operator +(UsageModel other) {
    return UsageModel(
      screenTime: screenTime + other.screenTime,
      mobileData: mobileData + other.mobileData,
      wifiData: wifiData + other.wifiData,
    );
  }

  factory UsageModel.fromMap(Map<dynamic, dynamic> map) {
    return UsageModel(
      screenTime: map["screenTime"] as int,
      mobileData: map["mobileData"] as int,
      wifiData: map["wifiData"] as int,
    );
  }

  @override
  String toString() =>
      'UsageModel(screenTime: $screenTime, mobileData: $mobileData, wifiData: $wifiData)';
}
