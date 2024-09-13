/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/apps_provider.dart';
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
  String nextScreenRoute = AppRoutes.homeScreen;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      1000.ms,
      _goToNextScreen,
    );
  }

  void _goToNextScreen() async {
    final isOnboardingDone =
        await MethodChannelService.instance.getOnboardingStatus();

    final perms =
        await ref.read(permissionProvider.notifier).fetchPermissionsStatus();

    final haveAllEssentialPermissions = perms.haveUsageAccessPermission &&
        perms.haveDisplayOverlayPermission &&
        perms.haveAlarmsPermission &&
        perms.haveNotificationPermission;

    if (!mounted) return;

    if (haveAllEssentialPermissions && isOnboardingDone) {
      ref.read(appsProvider);
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.onboardingScreen,
        arguments: isOnboardingDone,
      );
    }
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
              child: const RoundedContainer(
                circularRadius: 420,
                padding: EdgeInsets.all(12),
                child: Icon(FluentIcons.weather_sunny_low_20_filled, size: 64),
              ),
            ),

            const Column(
              children: [
                /// Title
                StyledText(
                  "Mindful",
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),

                /// Tag line
                StyledText(
                  "Focus on what truly Matters",
                  fontSize: 16,
                  isSubtitle: true,
                ),
              ],
            ),

            const Divider(color: Colors.transparent),
            0.vBox,

            /// Make
            const StyledText("Made with ♥️ in 🇮🇳", fontSize: 14),
          ].animate(effects: DefaultEffects.transitionIn),
        ),
      ),
    );
  }
}
