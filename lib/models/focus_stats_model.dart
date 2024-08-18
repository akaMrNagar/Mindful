import 'package:flutter/material.dart';

@immutable
class FocusStatsModel {
  final Duration todaysScreenTime;
  final Duration todaysFocusedTime;
  final Duration yesterdaysScreenTime;
  final Duration yesterdaysFocusedTime;
  final Duration lifetimeFocusedTime;
  final int successfulSessions;
  final int failedSessions;

  const FocusStatsModel({
    required this.todaysScreenTime,
    required this.todaysFocusedTime,
    required this.yesterdaysScreenTime,
    required this.yesterdaysFocusedTime,
    required this.lifetimeFocusedTime,
    required this.successfulSessions,
    required this.failedSessions,
  });
}
