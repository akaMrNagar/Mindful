/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/config/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mindful/core/services/routing_service.dart';
import 'package:mindful/providers/mindful_settings_provider.dart';

class MindfulApp extends ConsumerWidget {
  const MindfulApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(mindfulSettingsProvider.select((v) => v.themeMode));

    final accentColor =
        ref.watch(mindfulSettingsProvider.select((v) => v.accentColor));

    final localeCode =
        ref.watch(mindfulSettingsProvider.select((v) => v.localeCode));

    final useAmoledDark =
        ref.watch(mindfulSettingsProvider.select((v) => v.useAmoledDark));

    final useDynamicColors =
        ref.watch(mindfulSettingsProvider.select((v) => v.useDynamicColors));

    /// Apply transparent color to system ui background
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return DynamicColorBuilder(
      builder: (light, dark) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeAnimationCurve: Curves.ease,
        darkTheme: AppTheme.darkTheme(
          isAmoled: useAmoledDark,
          seedColor: useDynamicColors
              ? dark?.primary
              : AppTheme.materialColors[accentColor],
        ),
        theme: AppTheme.lightTheme(
          seedColor: useDynamicColors
              ? light?.primary
              : AppTheme.materialColors[accentColor],
        ),
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
        navigatorKey: RoutingService.navigatorKey,
      ),
    );
  }
}
