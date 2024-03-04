// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:mindful/core/extensions/ext_time_of_day.dart';

@immutable
class BedtimeScheduleInfo {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<bool> selectedDays;

  final bool bedtimeStatus;
  final bool pauseApps;
  final bool enableDND;

  const BedtimeScheduleInfo({
    this.startTime = const TimeOfDay(hour: 0, minute: 0),
    this.endTime = const TimeOfDay(hour: 0, minute: 0),
    this.selectedDays = const [false, true, true, true, true, true, false],
    this.bedtimeStatus = false,
    this.pauseApps = false,
    this.enableDND = false,
  });

  BedtimeScheduleInfo copyWith({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<bool>? selectedDays,
    bool? bedtimeStatus,
    bool? pauseApps,
    bool? enableDND,
  }) {
    return BedtimeScheduleInfo(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      selectedDays: selectedDays ?? this.selectedDays,
      bedtimeStatus: bedtimeStatus ?? this.bedtimeStatus,
      pauseApps: pauseApps ?? this.pauseApps,
      enableDND: enableDND ?? this.enableDND,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime.toMinutes(),
      'endTime': endTime.toMinutes(),
      'selectedDays': selectedDays,
      'bedtimeStatus': bedtimeStatus,
      'pauseApps': pauseApps,
      'enableDND': enableDND,
    };
  }

  factory BedtimeScheduleInfo.fromMap(Map<String, dynamic> map) {
    return BedtimeScheduleInfo(
      startTime: TimeOfDay.now().fromMinutes(map['startTime'] as int),
      endTime: TimeOfDay.now().fromMinutes(map['endTime'] as int),
      selectedDays: List<bool>.from(map['selectedDays'] as List<bool>),
      bedtimeStatus: map['bedtimeStatus'] as bool,
      pauseApps: map['pauseApps'] as bool,
      enableDND: map['enableDND'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory BedtimeScheduleInfo.fromJson(String source) =>
      BedtimeScheduleInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
