import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';

@immutable
class NotificationSchedule {
  /// Name or Label for the schedule
  final String label;

  /// [TimeOfDay] in minutes of the schedule.
  /// It is stored as total minutes.
  final TimeOfDayAdapter time;

  /// Boolean denoting the status of this notification schedule
  final bool isActive;

  const NotificationSchedule({
    required this.label,
    required this.time,
    required this.isActive,
  });

  NotificationSchedule copyWith({
    String? label,
    TimeOfDayAdapter? time,
    bool? isActive,
  }) {
    return NotificationSchedule(
      label: label ?? this.label,
      time: time ?? this.time,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'time': time.toMinutes,
      'isActive': isActive,
    };
  }

  factory NotificationSchedule.fromMap(Map<String, dynamic> map) {
    return NotificationSchedule(
      label: map['label'] ?? '',
      time: TimeOfDayAdapter.fromMinutes(map['time'] ?? 0),
      isActive: map['isActive'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationSchedule.fromJson(String source) =>
      NotificationSchedule.fromMap(json.decode(source));

  @override
  String toString() =>
      'NotificationSchedule(label: $label, time: $time, isActive: $isActive)';
}
