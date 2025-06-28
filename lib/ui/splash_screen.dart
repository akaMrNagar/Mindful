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
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/auth_service.dart';
import 'package:mindful/config/navigation/navigation_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/system/mindful_settings_provider.dart';
import 'package:mindful/providers/system/parental_controls_provider.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
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
  bool _isAppUpdated = false;

  @override
  void initState() {
    super.initState();
    _checkOnboardingAndPerms();
  }

  void _checkOnboardingAndPerms() async {
    final perms =
        await ref.read(permissionProvider.notifier).fetchPermissionsStatus();

    final settings = await ref.read(mindfulSettingsProvider.notifier).init();
    _isOnboardingDone = settings.isOnboardingDone;
    _isAppUpdated = settings.appVersion !=
        MethodChannelService.instance.deviceInfo.mindfulVersion;

    _isAccessProtected =
        (await ref.read(parentalControlsProvider.notifier).init())
            .protectedAccess;
    _haveAllEssentialPermissions = perms.haveUsageAccessPermission &&
        perms.haveDisplayOverlayPermission &&
        perms.haveAlarmsPermission &&
        perms.haveNotificationPermission;

    if (mounted) setState(() {});
    _isAccessProtected ? _authenticate() : _goToNextScreen(true);
  }

  void _goToNextScreen(bool shouldDelay) async {
    if (shouldDelay) await Future.delayed(250.ms);
    if (!mounted) return;

    if (_haveAllEssentialPermissions && _isOnboardingDone) {
      NavigationService.instance.init(showChangeLogsToo: _isAppUpdated);
    } else {
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.onboardingPath,
        arguments: {"isOnboardingDone": _isOnboardingDone},
      );
    }
  }

  void _authenticate() async {
    final isAuthenticated = await AuthService.instance.authenticate();

    /// Return if not mounted
    if (!mounted) return;

    /// If removed locks
    if (isAuthenticated == null) {
      context.showSnackAlert(
        context.locale.protected_access_removed_lock_snack_alert,
        icon: FluentIcons.fingerprint_20_filled,
      );
      return;
    }

    /// If aborted the auth
    if (!isAuthenticated) {
      context.showSnackAlert(
        context.locale.protected_access_failed_lock_snack_alert,
        icon: FluentIcons.fingerprint_20_filled,
      );

      return;
    }

    _goToNextScreen(false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) => SystemNavigator.pop(),
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
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  FluentIcons.target_arrow_20_regular,
                  size: 64,
                ),
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
            const StyledText(
              "Made with ♥️ in 🇮🇳",
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ].animate(
            effects: DefaultEffects.transitionIn,
            delay: 100.ms,
            interval: 100.ms,
          ),
        ),
      ),
    );
  }
}
