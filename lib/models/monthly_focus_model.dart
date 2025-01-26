import 'package:flutter/material.dart';

@immutable
class MonthlyFocusModel {
  final Map<DateTime, int> monthlyFocus;
  final int totalProductiveDays;
  final Duration totalProductiveTime;

  const MonthlyFocusModel({
    this.monthlyFocus = const {},
    this.totalProductiveDays = 0,
    this.totalProductiveTime = Duration.zero,
  });

  MonthlyFocusModel copyWith({
    Map<DateTime, int>? monthlyFocus,
    int? totalProductiveDays,
    Duration? totalProductiveTime,
  }) {
    return MonthlyFocusModel(
      monthlyFocus: monthlyFocus ?? this.monthlyFocus,
      totalProductiveDays: totalProductiveDays ?? this.totalProductiveDays,
      totalProductiveTime: totalProductiveTime ?? this.totalProductiveTime,
    );
  }

  @override
  String toString() => 'MonthlyFocusModel(monthlyFocus: $monthlyFocus, totalProductiveDays: $totalProductiveDays, totalProductiveTime: $totalProductiveTime)';
}
