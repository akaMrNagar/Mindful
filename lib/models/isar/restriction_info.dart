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
import 'package:isar/isar.dart';

part 'restriction_info.g.dart';

/// Restriction info model used in mapping app package to its focus info like
/// [timerSec], [internetAccess]
@immutable
@collection
class RestrictionInfo {
  /// ID for isar database
  Id get id => Isar.autoIncrement;

  /// Package name of the app this model and settings corresponds to
  @Index(unique: true)
  final String appPackage;

  /// App timer in seconds
  final int timerSec;

  /// Flag denoting if this app's can access internet or not
  final bool internetAccess;

  /// Info model for each installed app
  const RestrictionInfo({
    required this.appPackage,
    this.timerSec = 0,
    this.internetAccess = true,
  });

  RestrictionInfo copyWith({
    String? appPackage,
    int? timerSec,
    bool? internetAccess,
  }) {
    return RestrictionInfo(
      appPackage: appPackage ?? this.appPackage,
      timerSec: timerSec ?? this.timerSec,
      internetAccess: internetAccess ?? this.internetAccess,
    );
  }
}
