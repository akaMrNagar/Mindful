/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/onboarding/onboarding_page.dart';
import 'package:mindful/ui/onboarding/permission_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({
    required this.isOnboardingDone,
    super.key,
  });

  final bool isOnboardingDone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends ConsumerState<OnboardingScreen> {
  late PageController _controller;
  final _animCurve = Curves.fastEaseInToSlowEaseOut;
  final _animDuration = 300.ms;
  int _currentPage = 0;

  final pages = [
    const OnboardingPage(
      title: "Master Focus.",
      imgArtPath: "assets/illustrations/onboarding_4.png",
      description:
          "Pause distracting apps, block short content, and stay on track with customizable focus sessions. Whether you're working, studying, or relaxing, Mindful helps you stay in control.",
    ),
    const OnboardingPage(
      title: "Block Distractions.",
      imgArtPath: "assets/illustrations/onboarding_2.png",
      description:
          "Set usage limits, automatically pause apps, and create healthier digital habits. Use Bedtime Mode to unwind and enjoy a distraction-free night.",
    ),
    const OnboardingPage(
      title: "Privacy First.",
      imgArtPath: "assets/illustrations/onboarding_1.png",
      description:
          "Mindful is 100% open-source and operates entirely offline. We don't collect or share your personal data — your privacy is guaranteed in every way.",
    ),
    const PermissionsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    MethodChannelService.instance.getOnboardingStatus().then(
      (isDone) {
        if (isDone && _controller.hasClients) {
          _controller.animateToPage(
            pages.length - 1,
            duration: _animDuration,
            curve: _animCurve,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == pages.length - 1;
    final perms = ref.watch(permissionProvider);
    final haveAllEssentialPermissions = perms.haveUsageAccessPermission &&
        perms.haveDisplayOverlayPermission &&
        perms.haveAlarmsPermission &&
        perms.haveNotificationPermission;

    return PopScope(
      canPop: haveAllEssentialPermissions,
      onPopInvoked: (didPop) {
        if (!haveAllEssentialPermissions) {
          exit(0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 0,
        ),
        body: Stack(
          children: [
            /// Onboarding Page
            PageView.builder(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemCount: pages.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: pages[index],
              ),
            ),

            /// Overlay controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Skip button
                  TextButton(
                    onPressed: () => _controller.animateToPage(
                      pages.length - 1,
                      duration: _animDuration,
                      curve: _animCurve,
                    ),
                    child: const Text("Skip"),
                  ).animate(target: isLastPage ? 0 : 1).scale(duration: 100.ms),

                  /// Bottom controls
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Row(
                      children: [
                        /// Page Dots
                        SmoothPageIndicator(
                          controller: _controller,
                          count: pages.length,
                          effect: ExpandingDotsEffect(
                            dotWidth: 10,
                            dotHeight: 10,
                            spacing: 6,
                            expansionFactor: 2.5,
                            dotColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            activeDotColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const Spacer(),

                        /// Go to previous page
                        IconButton.filledTonal(
                          onPressed: () => _controller.previousPage(
                            curve: _animCurve,
                            duration: _animDuration,
                          ),
                          padding: const EdgeInsets.all(10),
                          icon: const Icon(FluentIcons.caret_left_20_filled),
                        )
                            .animate(
                              target: _currentPage > 0 && !isLastPage ? 1 : 0,
                            )
                            .scale(duration: 100.ms),
                        4.hBox,

                        isLastPage

                            /// Finish setup
                            ? FilledButton(
                                onPressed: haveAllEssentialPermissions
                                    ? () {
                                        MethodChannelService.instance
                                            .setOnboardingDone();
                                        Navigator.of(context).maybePop();
                                      }
                                    : null,
                                child: const Text("Finish Setup"),
                              ).animate(target: isLastPage ? 1 : 0).scale(
                                  duration: 200.ms,
                                  alignment: Alignment.centerRight,
                                )

                            /// Go to next page
                            : IconButton.filled(
                                padding: const EdgeInsets.all(10),
                                onPressed: () => _controller.nextPage(
                                  curve: _animCurve,
                                  duration: _animDuration,
                                ),
                                icon: const Icon(
                                    FluentIcons.caret_right_20_filled),
                              )
                                .animate(target: isLastPage ? 0 : 1)
                                .scale(duration: 100.ms),

                        /// Finish setup
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
