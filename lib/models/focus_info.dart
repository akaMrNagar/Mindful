import 'package:flutter/material.dart';
import 'package:mindful/core/utils/constants.dart';

@immutable
class FocusInfo {
  final String profile;
  final int timer;
  final bool isModifiable;

  const FocusInfo({
    this.profile = Constants.defaultProfile,
    this.timer = 0,
    this.isModifiable = true,
  });

  FocusInfo copyWith({
    String? profile,
    int? timer,
    bool? isModifiable,
  }) {
    return FocusInfo(
      profile: profile ?? this.profile,
      timer: timer ?? this.timer,
      isModifiable: isModifiable ?? this.isModifiable,
    );
  }
}
