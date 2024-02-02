// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ScheduleInfo {
  final bool status;
  final bool dnd;
  final bool greyScale;
  final bool darkTheme;
  final TimeOfDay start;
  final TimeOfDay end;
  final List<bool> selectedDays;

  ScheduleInfo({
    this.status = false,
    this.dnd = false,
    this.greyScale = false,
    this.darkTheme = false,
    this.start = const TimeOfDay(hour: 0, minute: 0),
    this.end = const TimeOfDay(hour: 0, minute: 0),
    this.selectedDays = const [false, false, false, false, false, false, false],
  });

  ScheduleInfo copyWith({
    bool? status,
    bool? dnd,
    bool? greyScale,
    bool? darkTheme,
    TimeOfDay? start,
    TimeOfDay? end,
    List<bool>? selectedDays,
  }) {
    return ScheduleInfo(
      status: status ?? this.status,
      dnd: dnd ?? this.dnd,
      greyScale: greyScale ?? this.greyScale,
      darkTheme: darkTheme ?? this.darkTheme,
      start: start ?? this.start,
      end: end ?? this.end,
      selectedDays: selectedDays ?? this.selectedDays,
    );
  }
}
