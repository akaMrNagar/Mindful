/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mindful/models/isar/focus_session.dart';

@immutable
class FocusTimelineModel {
  final Map<DateTime, int> daysTypeMap;
  final int totalProductiveDays;
  final Duration totalProductiveTime;
  final Duration todaysFocusedTime;
  final AsyncValue<List<FocusSession>> todaysSessions;

  const FocusTimelineModel({
    this.daysTypeMap = const {},
    this.totalProductiveDays = 0,
    this.totalProductiveTime = Duration.zero,
    this.todaysFocusedTime = Duration.zero,
    this.todaysSessions = const AsyncLoading(),
  });

  FocusTimelineModel copyWith({
    Map<DateTime, int>? daysTypeMap,
    int? totalProductiveDays,
    Duration? totalProductiveTime,
    Duration? todaysFocusedTime,
    AsyncValue<List<FocusSession>>? todaysSessions,
  }) {
    return FocusTimelineModel(
      daysTypeMap: daysTypeMap ?? this.daysTypeMap,
      totalProductiveDays: totalProductiveDays ?? this.totalProductiveDays,
      totalProductiveTime: totalProductiveTime ?? this.totalProductiveTime,
      todaysFocusedTime: todaysFocusedTime ?? this.todaysFocusedTime,
      todaysSessions: todaysSessions ?? this.todaysSessions,
    );
  }
}
