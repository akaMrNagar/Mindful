import 'dart:convert';

/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'crash_log.g.dart';

@immutable
@collection
class CrashLog {
  /// ID for isar database
  Id get id => Isar.autoIncrement;

  /// Current version of Mindful app
  final String appVersion;

  /// Time in milliseconds from epoch when the error was thrown
  final int timeStampEpoch;

  /// The error string
  final String error;

  /// Stack trace when the error or exception was thrown
  final String stackTrace;

  const CrashLog({
    required this.appVersion,
    required this.timeStampEpoch,
    required this.error,
    required this.stackTrace,
  });

  Map<String, String> toLogMap() {
    return {
      'appVersion': appVersion,
      'timeStampEpoch':
          DateTime.fromMillisecondsSinceEpoch(timeStampEpoch).toString(),
      'error': error,
      'stackTrace': stackTrace,
    };
  }

  String toJson() => json.encode(toLogMap());

  @override
  String toString() {
    return 'CrashLog(appVersion: $appVersion, timeStampEpoch: $timeStampEpoch, error: $error, stackTrace: $stackTrace)';
  }
}
