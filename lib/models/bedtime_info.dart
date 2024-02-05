import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';

//FIXME - Make invincible mode bool reactive to the state of schedule activity [active, inactive]

class BedtimeInfo {
  final bool bedtimeStatus;
  final bool invincible;
  final bool pauseApps;
  final bool dnd;
  final bool greyScale;
  final bool darkTheme;
  final TimeOfDay start;
  final TimeOfDay end;
  final Duration duration;
  final List<bool> selectedDays;

  BedtimeInfo({
    this.bedtimeStatus = false,
    this.invincible = false,
    this.pauseApps = true,
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
    bool? invincible,
    bool? pauseApps,
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
      invincible: invincible ?? this.invincible,
      pauseApps: pauseApps ?? this.pauseApps,
      dnd: dnd ?? this.dnd,
      greyScale: greyScale ?? this.greyScale,
      darkTheme: darkTheme ?? this.darkTheme,
      start: start ?? this.start,
      end: end ?? this.end,
      duration: duration ?? this.duration,
      selectedDays: selectedDays ?? this.selectedDays,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bedtimeStatus': bedtimeStatus,
      'invincible': invincible,
      'pauseApps': pauseApps,
      'dnd': dnd,
      'greyScale': greyScale,
      'darkTheme': darkTheme,
      'start': start.toMinutes(),
      'end': end.toMinutes(),
      'duration': duration.inMinutes,
      'selectedDays': selectedDays,
    };
  }

  factory BedtimeInfo.fromMap(Map<String, dynamic> map) {
    return BedtimeInfo(
      bedtimeStatus: map['bedtimeStatus'] as bool,
      invincible: map['invincible'] as bool,
      pauseApps: map['pauseApps'] as bool,
      dnd: map['dnd'] as bool,
      greyScale: map['greyScale'] as bool,
      darkTheme: map['darkTheme'] as bool,
      start: TimeOfDay.now().fromMinutes(map['start'] as int),
      end: TimeOfDay.now().fromMinutes(map['end'] as int),
      duration: (map['duration'] as int).minutes,
      selectedDays: List<bool>.from((map['selectedDays'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory BedtimeInfo.fromJson(String source) =>
      BedtimeInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
