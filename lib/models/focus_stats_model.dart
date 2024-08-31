/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

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
    this.todaysScreenTime = Duration.zero,
    this.todaysFocusedTime = Duration.zero,
    this.yesterdaysScreenTime = Duration.zero,
    this.yesterdaysFocusedTime = Duration.zero,
    this.lifetimeFocusedTime = Duration.zero,
    this.successfulSessions = 0,
    this.failedSessions = 0,
  });

  FocusStatsModel copyWith({
    Duration? todaysScreenTime,
    Duration? todaysFocusedTime,
    Duration? yesterdaysScreenTime,
    Duration? yesterdaysFocusedTime,
    Duration? lifetimeFocusedTime,
    int? successfulSessions,
    int? failedSessions,
  }) {
    return FocusStatsModel(
      todaysScreenTime: todaysScreenTime ?? this.todaysScreenTime,
      todaysFocusedTime: todaysFocusedTime ?? this.todaysFocusedTime,
      yesterdaysScreenTime: yesterdaysScreenTime ?? this.yesterdaysScreenTime,
      yesterdaysFocusedTime: yesterdaysFocusedTime ?? this.yesterdaysFocusedTime,
      lifetimeFocusedTime: lifetimeFocusedTime ?? this.lifetimeFocusedTime,
      successfulSessions: successfulSessions ?? this.successfulSessions,
      failedSessions: failedSessions ?? this.failedSessions,
    );
  }
}
