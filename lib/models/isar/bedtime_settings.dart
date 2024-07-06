import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';

part 'bedtime_settings.g.dart';

/// Bedtime model used for determining the actions to perform when bedtime schedule task starts.
@immutable
@collection
class BedtimeSettings {
  /// ID for isar database
  Id get id => 0;

  /// Getter for bedtime start [TimeOfDay]
  @ignore
  TimeOfDay get startTime => startTimeInMins.toTimeOfDay;

  /// Getter for bedtime end [TimeOfDay]
  @ignore
  TimeOfDay get endTime => endTimeInMins.toTimeOfDay;

  /// Getter for total duration between [startTime] amd [endTime]
  @ignore
  Duration get totalDuration => endTime.difference(startTime);

  /// [TimeOfDay] in seconds from where the bedtime schedule task will start.
  /// It is stored as total minutes.
  final int startTimeInMins;

  /// [TimeOfDay] in seconds when the bedtime schedule task will end
  /// It is stored as total minutes.
  final int endTimeInMins;

  /// Days on which the task will execute.
  /// The list contains 7 booleans for each day of week.
  /// [TRUE] indicates that schedule task will run that day.
  /// [FALSE] indicates that schedule task will skip that day.
  final List<bool> scheduleDays;

  /// Boolean denoting the status of the bedtime schedule means
  /// [For User] if the schedule is running or not.
  /// [For Developer]  if the task worker is scheduled or cancelled.
  final bool isScheduleOn;

  /// Boolean denoting if bedtime settings can be modified or not.
  ///
  /// This will be FALSE if inivincible mode is ON and the user is
  /// modifiying bedtime setting during the bedtime schedule period
  final bool isModifiable;

  /// Boolean denoting if to start DO NOT DISTURB mode or not when bedtime starts.
  final bool shouldStartDnd;

  /// List of app's packages which are selected as distracting apps.
  final List<String> distractingApps;

  /// Bedtime model used for determining the actions to perform when bedtime schedule task starts.
  const BedtimeSettings({
    this.startTimeInMins = 0,
    this.endTimeInMins = 0,
    this.scheduleDays = const [false, true, true, true, true, true, false],
    this.isScheduleOn = false,
    this.isModifiable = true,
    this.shouldStartDnd = false,
    this.distractingApps = const [],
  });

  /// NOTE: Don't modify this method.
  /// This can lead to json deserializaion error on native side
  /// in [BedtimeSettings] model's constructor
  Map<String, dynamic> _toMapForSharedPrefs() {
    return {
      'isScheduleOn': isScheduleOn,
      'startTimeInMins': startTimeInMins,
      // Added [totalDurationSec] this to map for native worker task
      'totalDurationMins': totalDuration.inMinutes,
      'shouldStartDnd': shouldStartDnd,
      'scheduleDays': scheduleDays,
      'distractingApps': distractingApps,
    };
  }

  String toJson() => json.encode(_toMapForSharedPrefs());

  BedtimeSettings copyWith({
    int? startTimeInMins,
    int? endTimeInMins,
    List<bool>? scheduleDays,
    bool? isScheduleOn,
    bool? isModifiable,
    bool? shouldStartDnd,
    List<String>? distractingApps,
  }) {
    return BedtimeSettings(
      startTimeInMins: startTimeInMins ?? this.startTimeInMins,
      endTimeInMins: endTimeInMins ?? this.endTimeInMins,
      scheduleDays: scheduleDays ?? this.scheduleDays,
      isScheduleOn: isScheduleOn ?? this.isScheduleOn,
      isModifiable: isModifiable ?? this.isModifiable,
      shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
      distractingApps: distractingApps ?? this.distractingApps,
    );
  }

  @override
  String toString() {
    return 'BedtimeSettings(startTimeInMins: $startTimeInMins, endTimeInMins: $endTimeInMins, scheduleDays: $scheduleDays, isScheduleOn: $isScheduleOn, isModifiable: $isModifiable, shouldStartDnd: $shouldStartDnd, distractingApps: $distractingApps)';
  }
}
