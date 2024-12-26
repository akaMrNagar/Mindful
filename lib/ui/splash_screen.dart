/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/auth_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/mindful_settings_provider.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/breathing_widget.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/transitions/default_effects.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _haveAllEssentialPermissions = false;
  bool _isOnboardingDone = false;
  bool _isAccessProtected = false;

  @override
  void initState() {
    super.initState();
    _goToNextScreen();
  }

  void _goToNextScreen() async {
    final settings = await ref.read(mindfulSettingsProvider.notifier).init();
    final perms =
        await ref.read(permissionProvider.notifier).fetchPermissionsStatus();

    _isOnboardingDone = settings.isOnboardingDone;
    _isAccessProtected = settings.protectedAccess;
    _haveAllEssentialPermissions = perms.haveUsageAccessPermission &&
        perms.haveDisplayOverlayPermission &&
        perms.haveAlarmsPermission &&
        perms.haveNotificationPermission;

    if (mounted) setState(() {});

    /// Initialize necessary providers and services
    if (_haveAllEssentialPermissions && _isOnboardingDone) {
      initializeNecessaryProviders(ref);
    }

    _isAccessProtected
        ? _authenticate()
        : Future.delayed(
            _haveAllEssentialPermissions && _isOnboardingDone ? 750.ms : 0.ms,
            _pushNextScreen,
          );
  }

  void _pushNextScreen() {
    if (!mounted) return;

    if (_haveAllEssentialPermissions && _isOnboardingDone) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.homeScreen,
        (_) => false,
      );
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.onboardingScreen,
        (_) => false,
        arguments: _isOnboardingDone,
      );
    }
  }

  void _authenticate() async {
    final isSuccess = await AuthService.instance.authenticate();
    if (isSuccess) _pushNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// Breathing logo
            BreathingWidget(
              dimension: min(420, MediaQuery.of(context).size.width * 0.8),
              child: RoundedContainer(
                circularRadius: 420,
                color: Theme.of(context).colorScheme.secondaryContainer,
                padding: const EdgeInsets.all(12),
                child: const Icon(FluentIcons.weather_sunny_low_20_filled,
                    size: 64),
              ),
            ),

            Column(
              children: [
                /// Title
                const StyledText(
                  "Mindful",
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),

                /// Tag line
                StyledText(
                  context.locale.mindful_tagline,
                  fontSize: 16,
                  isSubtitle: true,
                ),
              ],
            ),

            const Divider(color: Colors.transparent),
            _isAccessProtected
                ? FilledButton.icon(
                    icon: const Icon(FluentIcons.fingerprint_20_regular),
                    label: Text(context.locale.unlock_button_label),
                    onPressed: _authenticate,
                  )
                : 0.vBox,

            /// Make
            const StyledText("Made with ♥️ in 🇮🇳", fontSize: 14),
          ].animate(effects: DefaultEffects.transitionIn),
        ),
      ),
    );
  }
}
