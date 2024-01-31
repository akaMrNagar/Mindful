import 'package:flutter/material.dart';

@immutable
class FocusProfile {
  final String profileLabel;
  final int timer;
  final bool isModifiable;
  final List<String> apps;

  const FocusProfile({
    required this.profileLabel,
    required this.timer,
    required this.isModifiable,
    required this.apps,
  });

  FocusProfile copyWith({
    String? profileLabel,
    int? timer,
    bool? isModifiable,
    List<String>? apps,
  }) {
    return FocusProfile(
      profileLabel: profileLabel ?? this.profileLabel,
      timer: timer ?? this.timer,
      isModifiable: isModifiable ?? this.isModifiable,
      apps: apps ?? this.apps,
    );
  }
}
