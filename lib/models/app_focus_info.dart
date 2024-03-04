import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class AppFocusInfo {
  final int timer;
  final bool isInvincible;
  final int lastEmergencyUsed;

  const AppFocusInfo({
    this.timer = 0,
    this.isInvincible = false,
    this.lastEmergencyUsed = 0,
  });

  AppFocusInfo copyWith({
    int? timer,
    bool? isInvincible,
    int? lastEmergencyUsed,
  }) {
    return AppFocusInfo(
      timer: timer ?? this.timer,
      isInvincible: isInvincible ?? this.isInvincible,
      lastEmergencyUsed: lastEmergencyUsed ?? this.lastEmergencyUsed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timer': timer,
      'isInvincible': isInvincible,
      'lastEmergencyUsed': lastEmergencyUsed,
    };
  }

  factory AppFocusInfo.fromMap(Map<String, dynamic> map) {
    return AppFocusInfo(
      timer: map['timer']?.toInt() ?? 0,
      isInvincible: map['isInvincible'] ?? false,
      lastEmergencyUsed: map['lastEmergencyUsed']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppFocusInfo.fromJson(String source) =>
      AppFocusInfo.fromMap(json.decode(source));

  @override
  String toString() =>
      'AppFocusInfo(timer: $timer, isInvincible: $isInvincible, lastEmergencyUsed: $lastEmergencyUsed)';
}
