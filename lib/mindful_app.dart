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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/config/app_themes.dart';
import 'package:mindful/providers/new/mindful_settings_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MindfulApp extends ConsumerWidget {
  const MindfulApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(mindfulSettingsNotifierProvider.select((v) => v.themeMode));

    final accentColor =
        ref.watch(mindfulSettingsNotifierProvider.select((v) => v.accentColor));

    final localeCode =
        ref.watch(mindfulSettingsNotifierProvider.select((v) => v.localeCode));

    final useAmoledDark = ref
        .watch(mindfulSettingsNotifierProvider.select((v) => v.useAmoledDark));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme(accentColor, useAmoledDark),
      theme: AppTheme.lightTheme(accentColor),
      themeMode: ThemeMode.values[themeMode.index],
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localeCode),
    );
  }
}
