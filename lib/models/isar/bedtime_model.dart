import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mindful/core/extensions/ext_int.dart';

part 'bedtime_model.g.dart';

/// Bedtime model used for determining the actions to perform when bedtime schedule task starts.
@immutable
@collection
class BedtimeModel {
  /// ID for isar database
  Id get id => 0;

  /// [TimeOfDay] in minutes from where the bedtime schedule task will start.
  /// It is stored as total minutes.
  final int startTimeInMinutes;

  /// Getter for bedtime start [TimeOfDay]
  @ignore
  TimeOfDay get startTime => startTimeInMinutes.toTimeOfDay;

  /// [TimeOfDay] in minutes when the bedtime schedule task will end
  /// It is stored as total minutes.
  final int endTimeInMinutes;

  /// Getter for bedtime end [TimeOfDay]
  @ignore
  TimeOfDay get endTime => endTimeInMinutes.toTimeOfDay;

  /// Days on which the task will execute.
  /// The list contains 7 booleans for each day of week.
  /// [TRUE] indicates that schedule task will run that day.
  /// [FALSE] indicates that schedule task will skip that day.
  final List<bool> scheduleDays;

  /// Boolean denoting the status of the bedtime schedule means
  /// [For User] if the schedule is running or not.
  /// [For Developer]  if the task worker is scheduled or cancelled.
  final bool scheduleStatus;

  /// Boolean denoting if to pause app or not when bedtime starts.
  final bool startScreenLockdown;

  /// Boolean denoting if to pause app's internet or not when bedtime starts.
  final bool startInternetLockdown;

  /// Boolean denoting if to start DO NOT DISTURB mode or not when bedtime starts.
  final bool startDnd;

  /// List of app's packages which are selected as distractiong apps.
  /// The [startScreenLockdown] and [startInternetLockdown] actions will be applied to
  /// these apps.
  final List<String> distractionApps;

  /// Bedtime model used for determining the actions to perform when bedtime schedule task starts.
  const BedtimeModel({
    this.startTimeInMinutes = 0,
    this.endTimeInMinutes = 0,
    this.scheduleDays = const [false, true, true, true, true, true, false],
    this.scheduleStatus = false,
    this.startScreenLockdown = false,
    this.startInternetLockdown = false,
    this.startDnd = false,
    this.distractionApps = const [],
  });

  BedtimeModel copyWith({
    int? startTimeInMinutes,
    int? endTimeInMinutes,
    List<bool>? scheduleDays,
    bool? scheduleStatus,
    bool? startScreenLockdown,
    bool? startInternetLockdown,
    bool? startDnd,
    List<String>? distractionApps,
  }) {
    return BedtimeModel(
      startTimeInMinutes: startTimeInMinutes ?? this.startTimeInMinutes,
      endTimeInMinutes: endTimeInMinutes ?? this.endTimeInMinutes,
      scheduleDays: scheduleDays ?? this.scheduleDays,
      scheduleStatus: scheduleStatus ?? this.scheduleStatus,
      startScreenLockdown: startScreenLockdown ?? this.startScreenLockdown,
      startInternetLockdown:
          startInternetLockdown ?? this.startInternetLockdown,
      startDnd: startDnd ?? this.startDnd,
      distractionApps: distractionApps ?? this.distractionApps,
    );
  }
}
