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

  /// Boolean denoting if to pause [distractingApps] or not when bedtime starts.
  final bool shouldPauseApps;

  /// Boolean denoting if to block [distractingApps] internet or not when bedtime starts.
  final bool shouldBlockInternet;

  /// Boolean denoting if to start DO NOT DISTURB mode or not when bedtime starts.
  final bool shouldStartDnd;

  /// List of app's packages which are selected as distracting apps.
  /// The [shouldPauseApps] and [shouldBlockInternet] actions will be applied to
  /// these apps.
  final List<String> distractingApps;

  /// Bedtime model used for determining the actions to perform when bedtime schedule task starts.
  const BedtimeSettings({
    this.startTimeInMins = 0,
    this.endTimeInMins = 0,
    this.scheduleDays = const [false, true, true, true, true, true, false],
    this.isScheduleOn = false,
    this.shouldPauseApps = false,
    this.shouldBlockInternet = false,
    this.shouldStartDnd = false,
    this.distractingApps = const [],
  });

  BedtimeSettings copyWith({
    int? startTimeInMins,
    int? endTimeInMins,
    List<bool>? scheduleDays,
    bool? isScheduleOn,
    bool? shouldPauseApps,
    bool? shouldBlockInternet,
    bool? shouldStartDnd,
    List<String>? distractingApps,
  }) {
    return BedtimeSettings(
      startTimeInMins: startTimeInMins ?? this.startTimeInMins,
      endTimeInMins: endTimeInMins ?? this.endTimeInMins,
      scheduleDays: scheduleDays ?? this.scheduleDays,
      isScheduleOn: isScheduleOn ?? this.isScheduleOn,
      shouldPauseApps: shouldPauseApps ?? this.shouldPauseApps,
      shouldBlockInternet: shouldBlockInternet ?? this.shouldBlockInternet,
      shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
      distractingApps: distractingApps ?? this.distractingApps,
    );
  }

  /// NOTE: Don't modify this method.
  /// This can lead to json deserializaion error on native side
  /// in [BedtimeSettings] model's constructor
  Map<String, dynamic> toMap() {
    return {
      'startTimeInMins': startTimeInMins,
      'endTimeInMins': endTimeInMins,
      'scheduleDays': scheduleDays,
      // Added [totoalDurationSec] this to map for native worker task
      'totalDurationMins': totalDuration.inMinutes,
      'isScheduleOn': isScheduleOn,
      'shouldPauseApps': shouldPauseApps,
      'shouldBlockInternet': shouldBlockInternet,
      'shouldStartDnd': shouldStartDnd,
      'distractingApps': distractingApps,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'BedtimeSettings(startTimeInMins: $startTimeInMins, endTimeInMins: $endTimeInMins, scheduleDays: $scheduleDays, isScheduleOn: $isScheduleOn, shouldPauseApps: $shouldPauseApps, shouldBlockInternet: $shouldBlockInternet, shouldStartDnd: $shouldStartDnd, distractingApps: $distractingApps)';
  }
}
