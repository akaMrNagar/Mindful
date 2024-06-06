import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'focus_settings.g.dart';

/// Focus info model used in mapping app package to its focus settings like
/// [timer], [emergencyCounter] and [lastEmergencyTime]
@immutable
@collection
class FocusSettings {
  /// ID for isar database
  Id get id => Isar.autoIncrement;

  /// Package name of the app this model and settings corresponds to
  @Index(unique: true)
  final String appPackage;

  /// App timer in seconds
  final int timer;

  /// Number of emergencies used till now on today from midnight 12
  final int emergencyCounter;

  /// Timestamp describing the last time emergency is used by this app
  final DateTime? lastEmergencyTime;

  /// Focus model used in mapping app package to its focus settings like
  /// [timer], [emergencyCounter] and [lastEmergencyTime]
  const FocusSettings({
    required this.appPackage,
    this.lastEmergencyTime,
    this.timer = 0,
    this.emergencyCounter = 0,
  });

  FocusSettings copyWith({
    String? appPackage,
    int? timer,
    int? emergencyCounter,
    DateTime? lastEmergencyTime,
  }) {
    return FocusSettings(
      appPackage: appPackage ?? this.appPackage,
      timer: timer ?? this.timer,
      emergencyCounter: emergencyCounter ?? this.emergencyCounter,
      lastEmergencyTime: lastEmergencyTime ?? this.lastEmergencyTime,
    );
  }

  @override
  String toString() {
    return 'FocusSettings(appPackage: $appPackage, timer: $timer, emergencyCounter: $emergencyCounter, lastEmergencyTime: $lastEmergencyTime)';
  }
}
