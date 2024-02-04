// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BedtimeInfo {
  final bool bedtimeStatus;
  final bool dnd;
  final bool greyScale;
  final bool darkTheme;
  final TimeOfDay start;
  final TimeOfDay end;
  final Duration duration;
  final List<bool> selectedDays;

  BedtimeInfo({
    this.bedtimeStatus = false,
    this.dnd = false,
    this.greyScale = false,
    this.darkTheme = false,
    this.duration = Duration.zero,
    this.start = const TimeOfDay(hour: 0, minute: 0),
    this.end = const TimeOfDay(hour: 0, minute: 0),
    this.selectedDays = const [false, true, true, true, true, true, false],
  });

  BedtimeInfo copyWith({
    bool? bedtimeStatus,
    bool? dnd,
    bool? greyScale,
    bool? darkTheme,
    TimeOfDay? start,
    TimeOfDay? end,
    Duration? duration,
    List<bool>? selectedDays,
  }) {
    return BedtimeInfo(
      bedtimeStatus: bedtimeStatus ?? this.bedtimeStatus,
      dnd: dnd ?? this.dnd,
      greyScale: greyScale ?? this.greyScale,
      darkTheme: darkTheme ?? this.darkTheme,
      start: start ?? this.start,
      end: end ?? this.end,
      duration: duration ?? this.duration,
      selectedDays: selectedDays ?? this.selectedDays,
    );
  }
}
