import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/onboarding/setup_finish_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MindfulOnboardingState();
}

class _MindfulOnboardingState extends ConsumerState<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final perms = ref.watch(permissionProvider);

    final haveAllEssentialPermissions = perms.haveUsageAccessPermission &&
        perms.haveDisplayOverlayPermission &&
        perms.haveAlarmsPermission &&
        perms.haveNotificationPermission;

    final deviceHeight = MediaQuery.of(context).size.longestSide;

    return PopScope(
      canPop: haveAllEssentialPermissions,
      onPopInvoked: (didPop) {
        if (!haveAllEssentialPermissions) {
          exit(0);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: OnBoardingSlider(
          totalPage: 6,
          headerBackgroundColor: Theme.of(context).colorScheme.surface,
          pageBackgroundColor: Theme.of(context).colorScheme.surface,
          controllerColor: Theme.of(context).colorScheme.primary,
          speed: 3,
          indicatorAbove: true,
          indicatorPosition: 24,
          skipTextButton: const StyledText("Skip"),
          addButton: false,
          centerBackground: true,
          background: [
            _bgBuilder(deviceHeight, 'assets/illustrations/onboarding_1.png'),
            _bgBuilder(deviceHeight, 'assets/illustrations/onboarding_2.png'),
            _bgBuilder(deviceHeight, 'assets/illustrations/onboarding_3.png'),
            _bgBuilder(deviceHeight, 'assets/illustrations/onboarding_4.png'),
            _bgBuilder(deviceHeight, 'assets/illustrations/onboarding_5.png'),
            _bgBuilder(deviceHeight, 'assets/illustrations/onboarding_6.png'),
          ],
          pageBodies: [
            _bodyBuilder(
              deviceHeight: deviceHeight,
              title: "Focus Mode",
              description:
                  "Focus Mode boosts productivity by blocking distractions. Pause apps and track your progress over time to see your growth.",
            ),
            _bodyBuilder(
              deviceHeight: deviceHeight,
              title: "Doom Scrolling",
              description:
                  "Break free from doom scrolling. Set timers for apps and addictive short-form content and reclaim your time.",
            ),
            _bodyBuilder(
              deviceHeight: deviceHeight,
              title: "Peaceful Routine",
              description:
                  "End your day right with Smart Bedtime Mode. Pause distracting apps and enable Do Not Disturb for a peaceful sleep.",
            ),
            _bodyBuilder(
              deviceHeight: deviceHeight,
              title: "Digital Detox",
              description:
                  "Stay focused online. Block internet access for apps and distracting websites along with adult websites with one click.",
            ),
            _bodyBuilder(
              deviceHeight: deviceHeight,
              title: "Digital Cravings",
              description:
                  "Conquer digital cravings with Invincible Mode. Lock app timers, short content timers, and bedtime settings to stay disciplined and on track.",
            ),

            /// Last setup page
            _bodyBuilder(
              deviceHeight: deviceHeight,
              title: "Privacy First",
              description:
                  "Mindful is a Free and Open Source (FOSS) app, ad-free and offline. It doesn't collect or transfer user data, ensuring your privacy.",
              finish: SetupFinishButton(
                haveAllEssentialPermissions: haveAllEssentialPermissions,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bgBuilder(double deviceHeight, String path) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 720,
          maxHeight: 720,
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.asset(
            path,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  Widget _bodyBuilder({
    required double deviceHeight,
    required String title,
    required String description,
    Widget? finish,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(
        bottom: 32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Title
          StyledText(
            title,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
            color: Theme.of(context).colorScheme.primary,
          ),
          6.vBox,

          // Description
          StyledText(
            description,
            fontSize: 16,
            color: Theme.of(context).hintColor,
            textAlign: TextAlign.center,
          ),

          56.vBox,

          finish ?? 48.vBox,
        ],
      ),
    );
  }
}
