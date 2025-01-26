import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mindful/core/database/app_database.dart';

@immutable
class DatedFocusModel {
  final Duration selectedDaysFocusedTime;
  final AsyncValue<List<FocusSession>> selectedDaysSessions;

  const DatedFocusModel({
    this.selectedDaysFocusedTime = Duration.zero,
    this.selectedDaysSessions = const AsyncLoading(),
  });

  DatedFocusModel copyWith({
    Duration? selectedDaysFocusedTime,
    AsyncValue<List<FocusSession>>? selectedDaysSessions,
  }) {
    return DatedFocusModel(
      selectedDaysFocusedTime:
          selectedDaysFocusedTime ?? this.selectedDaysFocusedTime,
      selectedDaysSessions: selectedDaysSessions ?? this.selectedDaysSessions,
    );
  }

  @override
  String toString() => 'DatedFocusModel(selectedDaysFocusedTime: $selectedDaysFocusedTime, selectedDaysSessions: $selectedDaysSessions)';
}
