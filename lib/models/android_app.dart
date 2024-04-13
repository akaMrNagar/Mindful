import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mindful/core/enums/application_category.dart';

@immutable
class AndroidApp {
  /// Application label or name
  final String name;

  /// Unique package identifier for the app used by android system
  final String packageName;

  /// Does the app belong to system default category {Home Launcher, Dialer}
  /// It also include manually added apps like Tethering and Removed Apps
  final bool isImpSysApp;

  /// Category defined by the app's manifest file used by android system
  final AppCategory category;

  /// Total screen time usage of the app in this week as a list of int [in Seconds] for each day of week [7 days]
  final List<int> screenTimeThisWeek;

  /// Total cellular or mobile data usage of the app in this week as a list of int [in KBs] for each day of week [7 days]
  final List<int> mobileUsageThisWeek;

  /// Total wifi data usage of the app in this week as a list of int [in KBs] for each day of week [7 days]
  final List<int> wifiUsageThisWeek;

  /// Total sum of mobile and wifi data usage of the app in this week as a list of int [in KBs] for each day of week [7 days]
  final List<int> networkUsageThisWeek;

  /// Application icon provided by android system.
  final Uint8List icon;

  const AndroidApp({
    required this.name,
    required this.packageName,
    required this.icon,
    required this.isImpSysApp,
    required this.category,
    required this.screenTimeThisWeek,
    required this.mobileUsageThisWeek,
    required this.wifiUsageThisWeek,
    required this.networkUsageThisWeek,
  });

  factory AndroidApp.fromMap(Map<dynamic, dynamic> map) {
    return AndroidApp(
      name: map['appName'] as String,
      packageName: map['packageName'] as String,
      icon: base64Decode(map['appIcon'] as String),
      isImpSysApp: map['isImpSysApp'] as bool,
      category: _parseCategory(map['category'] as int),
      screenTimeThisWeek: _parseList(map['screenTimeThisWeek']),
      mobileUsageThisWeek: _parseList(map['mobileUsageThisWeek']),
      wifiUsageThisWeek: _parseList(map['wifiUsageThisWeek']),
      networkUsageThisWeek: _parseList(map['dataUsageThisWeek']),
    );
  }

  AndroidApp copyWith({
    String? name,
    String? packageName,
    bool? isImpSysApp,
    Uint8List? icon,
    AppCategory? category,
    List<int>? screenTimeThisWeek,
    List<int>? mobileUsageThisWeek,
    List<int>? wifiUsageThisWeek,
    List<int>? networkUsageThisWeek,
  }) {
    return AndroidApp(
      name: name ?? this.name,
      packageName: packageName ?? this.packageName,
      isImpSysApp: isImpSysApp ?? this.isImpSysApp,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      screenTimeThisWeek: screenTimeThisWeek ?? this.screenTimeThisWeek,
      mobileUsageThisWeek: mobileUsageThisWeek ?? this.mobileUsageThisWeek,
      wifiUsageThisWeek: wifiUsageThisWeek ?? this.wifiUsageThisWeek,
      networkUsageThisWeek: networkUsageThisWeek ?? this.networkUsageThisWeek,
    );
  }

  @override
  String toString() {
    return 'AndroidApp(name: $name, packageName: $packageName, isImpSysApp: $isImpSysApp, category: $category, screenTimeThisWeek: $screenTimeThisWeek, mobileUsageThisWeek: $mobileUsageThisWeek, wifiUsageThisWeek: $wifiUsageThisWeek, networkUsageThisWeek: $networkUsageThisWeek)';
  }

  @override
  bool operator ==(covariant AndroidApp other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.packageName == packageName &&
        other.isImpSysApp == isImpSysApp &&
        other.icon == icon &&
        other.category == category &&
        listEquals(other.screenTimeThisWeek, screenTimeThisWeek) &&
        listEquals(other.mobileUsageThisWeek, mobileUsageThisWeek) &&
        listEquals(other.wifiUsageThisWeek, wifiUsageThisWeek) &&
        listEquals(other.networkUsageThisWeek, networkUsageThisWeek);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        packageName.hashCode ^
        isImpSysApp.hashCode ^
        icon.hashCode ^
        category.hashCode ^
        screenTimeThisWeek.hashCode ^
        mobileUsageThisWeek.hashCode ^
        wifiUsageThisWeek.hashCode ^
        networkUsageThisWeek.hashCode;
  }

  static List<int> _parseList(List<Object?> list) {
    return list.map((e) => (e ?? 0) as int).toList();
  }

  static AppCategory _parseCategory(int index) {
    return switch (index) {
      -1 => AppCategory.undefined,
      0 => AppCategory.game,
      1 => AppCategory.audio,
      2 => AppCategory.video,
      3 => AppCategory.image,
      4 => AppCategory.social,
      5 => AppCategory.news,
      6 => AppCategory.maps,
      7 => AppCategory.productivity,
      8 => AppCategory.accessibility,
      int() => AppCategory.undefined,
    };
  }
}
