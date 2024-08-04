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
        perms.haveAlarmsPermission;

    return PopScope(
      canPop: haveAllEssentialPermissions,
      onPopInvoked: (didPop) {
        if (!haveAllEssentialPermissions) {
          exit(0);
        }
      },
      child: OnBoardingSlider(
        totalPage: 6,
        headerBackgroundColor: Theme.of(context).colorScheme.surface,
        pageBackgroundColor: Theme.of(context).colorScheme.surface,
        controllerColor: Theme.of(context).colorScheme.primary,
        speed: 3,
        centerBackground: true,
        indicatorAbove: true,
        indicatorPosition: 24,
        skipTextButton: const StyledText("Skip"),
        addButton: false,
        background: [
          Image.asset('assets/icons/fbReels.png'),
          Image.asset('assets/icons/snapSpotlight.png'),
          Image.asset('assets/icons/ytShorts.png'),
          Image.asset('assets/icons/instaReels.png'),
          Image.asset('assets/icons/snapSpotlight.png'),
          Image.asset('assets/icons/ytShorts.png'),
        ],
        pageBodies: [
          _bodyBuilder(
            title: "Fewer Distractions",
            description:
                "Master your screen time! Set app limits, pause distractions, and boost productivity.",
          ),
          _bodyBuilder(
            title: "Doom Scrolling",
            description:
                "Break free from doom scrolling. Set timers for addictive short-form content and reclaim your time.",
          ),
          _bodyBuilder(
            title: "Peaceful Routine",
            description:
                "End your day right with Smart Bedtime Mode. Pause distracting apps and enable Do Not Disturb for a peaceful sleep.",
          ),
          _bodyBuilder(
            title: "Detox Mind",
            description:
                "Surf safely and stay focused. Block adult sites and custom websites to create a cleaner, safer browsing experience.",
          ),
          _bodyBuilder(
            title: "Digital Cravings",
            description:
                "Conquer digital cravings with Invincible Mode. Lock app timers, short content timers, and bedtime settings to stay disciplined and on track.",
          ),

          /// Last setup page
          _bodyBuilder(
            title: "Privacy First",
            description:
                "Mindful is a Free and Open Source (FOSS) app, ad-free and offline. It doesn't collect or transfer user data, ensuring your privacy.",
            finish: SetupFinishButton(
              haveAllEssentialPermissions: haveAllEssentialPermissions,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyBuilder({
    required String title,
    required String description,
    Widget? finish,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Title
          StyledText(
            title,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
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
