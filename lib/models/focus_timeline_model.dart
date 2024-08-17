import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mindful/models/isar/focus_session.dart';

@immutable
class FocusTimelineModel {
  /// NOTE - Key for colors
  /// -1 for selected day
  /// 1 for productive days
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
