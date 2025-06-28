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
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/config/app_themes.dart';
import 'package:mindful/config/navigation/app_routes_observer.dart';
import 'package:mindful/config/navigation/navigation_service.dart';
import 'package:mindful/l10n/generated/app_localizations.dart';
import 'package:mindful/providers/system/mindful_settings_provider.dart';

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

    return DynamicColorBuilder(
      builder: (light, dark) {
        /// Apply transparent color to system ui background
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) => SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              systemNavigationBarContrastEnforced: true,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            ),
          ),
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,

          /// Themes
          themeAnimationCurve: Curves.ease,
          themeMode: ThemeMode.values[themeMode.index],
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

          /// Localization
          locale: Locale(localeCode),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          /// Navigation
          initialRoute: AppRoutes.rootSplashPath,
          routes: AppRoutes.routes,
          navigatorKey: NavigationService.navigatorKey,
          navigatorObservers: [AppRoutesObserver.instance],
        );
      },
    );
  }
}
