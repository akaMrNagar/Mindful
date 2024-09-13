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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/config/app_themes.dart';
import 'package:mindful/providers/settings_provider.dart';

class MindfulApp extends ConsumerWidget {
  const MindfulApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingsProvider.select((v) => v.themeMode));
    final materialColor = ref.watch(settingsProvider.select((v) => v.color));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme(materialColor),
      theme: AppTheme.lightTheme(materialColor),
      themeMode: themeMode,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
    );
  }
}
