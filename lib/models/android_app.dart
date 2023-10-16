// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum AppCategory {
  undefined,
  game,
  audio,
  video,
  image,
  social,
  news,
  maps,
  productivity,
  accessibility
}

class AndroidApp {
  final String name;
  final String packageName;

  /// Encoded string only used for mapping
  final String encodedIcon;
  final bool isImpSysApp;
  final AppCategory category;

  final List<int> screenTimeThisWeek;
  final List<int> mobileUsageThisWeek;
  final List<int> wifiUsageThisWeek;
  final List<int> dataUsageThisWeek;

  late Uint8List icon;

  /// Sum of wifi+mobile data usage for this week

  AndroidApp({
    required this.name,
    required this.packageName,
    required this.encodedIcon,
    required this.isImpSysApp,
    required this.category,
    required this.screenTimeThisWeek,
    required this.mobileUsageThisWeek,
    required this.wifiUsageThisWeek,
    required this.dataUsageThisWeek,
  }) {
    icon = base64Decode(encodedIcon);
  }

  factory AndroidApp.fromMap(Map<dynamic, dynamic> map) {
    return AndroidApp(
      name: map['appName'] as String,
      packageName: map['packageName'] as String,
      encodedIcon: map['appIcon'] as String,
      isImpSysApp: map['isImpSysApp'] as bool,
      category: _parseCategory(map['category'] as int),
      screenTimeThisWeek: _parseList(map['screenTimeThisWeek']),
      mobileUsageThisWeek: _parseList(map['mobileUsageThisWeek']),
      wifiUsageThisWeek: _parseList(map['wifiUsageThisWeek']),
      dataUsageThisWeek: _parseList(map['dataUsageThisWeek']),
    );
  }

  AndroidApp copyWith({
    String? name,
    String? packageName,
    bool? isImpSysApp,
    String? encodedIcon,
    AppCategory? category,
    List<int>? screenTimeThisWeek,
    List<int>? mobileUsageThisWeek,
    List<int>? wifiUsageThisWeek,
    List<int>? dataUsageThisWeek,
  }) {
    return AndroidApp(
      name: name ?? this.name,
      packageName: packageName ?? this.packageName,
      isImpSysApp: isImpSysApp ?? this.isImpSysApp,
      encodedIcon: encodedIcon ?? this.encodedIcon,
      category: category ?? this.category,
      screenTimeThisWeek: screenTimeThisWeek ?? this.screenTimeThisWeek,
      mobileUsageThisWeek: mobileUsageThisWeek ?? this.mobileUsageThisWeek,
      wifiUsageThisWeek: wifiUsageThisWeek ?? this.wifiUsageThisWeek,
      dataUsageThisWeek: dataUsageThisWeek ?? this.dataUsageThisWeek,
    );
  }

  @override
  String toString() {
    return 'AndroidApp(name: $name, packageName: $packageName, isImpSysApp: $isImpSysApp, category: $category, screenTimeThisWeek: $screenTimeThisWeek, mobileUsageThisWeek: $mobileUsageThisWeek, wifiUsageThisWeek: $wifiUsageThisWeek, dataUsageThisWeek: $dataUsageThisWeek)';
  }

  @override
  bool operator ==(covariant AndroidApp other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.packageName == packageName &&
        other.isImpSysApp == isImpSysApp &&
        other.encodedIcon == encodedIcon &&
        other.category == category &&
        listEquals(other.screenTimeThisWeek, screenTimeThisWeek) &&
        listEquals(other.mobileUsageThisWeek, mobileUsageThisWeek) &&
        listEquals(other.wifiUsageThisWeek, wifiUsageThisWeek) &&
        listEquals(other.dataUsageThisWeek, dataUsageThisWeek);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        packageName.hashCode ^
        isImpSysApp.hashCode ^
        encodedIcon.hashCode ^
        category.hashCode ^
        screenTimeThisWeek.hashCode ^
        mobileUsageThisWeek.hashCode ^
        wifiUsageThisWeek.hashCode ^
        dataUsageThisWeek.hashCode;
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
