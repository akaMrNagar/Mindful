/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/crash_log_service.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/mindful_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize method channel
  await MethodChannelService.instance.init();

  /// Initialize drift Database
  await DriftDbService.instance.init();

  /// Initialize local crashlytics
  await CrashLogService.instance.init();

  FlutterError.onError = (errorDetails) {
    CrashLogService.instance.recordCrashError(
      errorDetails.exception.toString(),
      errorDetails.stack.toString(),
    );

    if (kDebugMode) {
      FlutterError.presentError(errorDetails);
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    CrashLogService.instance.recordCrashError(
      error.toString(),
      stack.toString(),
    );
    return true;
  };

  /// Scale app from edge-edge behind system ui
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );

  /// run main app
  runApp(
    const ProviderScope(
      child: MindfulApp(),
    ),
  );
}
