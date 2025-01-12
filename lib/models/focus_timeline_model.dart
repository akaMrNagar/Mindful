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
import 'package:mindful/core/database/app_database.dart';

@immutable
class FocusTimelineModel {
  final Map<DateTime, int> monthlyFocusTimeMap;
  final int totalProductiveDays;
  final Duration totalProductiveTime;
  final Duration selectedDaysFocusedTime;
  final AsyncValue<List<FocusSession>> selectedDaysSessions;

  const FocusTimelineModel({
    this.monthlyFocusTimeMap = const {},
    this.totalProductiveDays = 0,
    this.totalProductiveTime = Duration.zero,
    this.selectedDaysFocusedTime = Duration.zero,
    this.selectedDaysSessions = const AsyncLoading(),
  });

  FocusTimelineModel copyWith({
    Map<DateTime, int>? monthlyFocusTimeMap,
    int? totalProductiveDays,
    Duration? totalProductiveTime,
    Duration? selectedDaysFocusedTime,
    AsyncValue<List<FocusSession>>? selectedDaysSessions,
  }) {
    return FocusTimelineModel(
      monthlyFocusTimeMap: monthlyFocusTimeMap ?? this.monthlyFocusTimeMap,
      totalProductiveDays: totalProductiveDays ?? this.totalProductiveDays,
      totalProductiveTime: totalProductiveTime ?? this.totalProductiveTime,
      selectedDaysFocusedTime: selectedDaysFocusedTime ?? this.selectedDaysFocusedTime,
      selectedDaysSessions: selectedDaysSessions ?? this.selectedDaysSessions,
    );
  }
}
