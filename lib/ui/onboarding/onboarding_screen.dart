/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/permissions_model.dart';
import 'package:mindful/providers/mindful_settings_provider.dart';
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
  int _currentPage = 0;
  ProviderSubscription? _subscription;
  final PageController _controller = PageController();
  final _animCurve = Curves.easeInOut;
  final _animDuration = AppConstants.defaultAnimDuration;
  late final List<Widget> _pages = [
    OnboardingPage(
      title: context.locale.onboarding_page_one_title,
      imgArtPath: "assets/illustrations/onboarding_1.png",
      description: context.locale.onboarding_page_one_info,
    ),
    OnboardingPage(
      title: context.locale.onboarding_page_two_title,
      imgArtPath: "assets/illustrations/onboarding_2.png",
      description: context.locale.onboarding_page_two_info,
    ),
    OnboardingPage(
      title: context.locale.onboarding_page_three_title,
      imgArtPath: "assets/illustrations/onboarding_3.png",
      description: context.locale.onboarding_page_three_info,
    ),
    const PermissionsPage(),
  ];

  @override
  void initState() {
    super.initState();

    /// Listen to permission changes an finish onboarding when
    /// user have granted all essential permissions
    _subscription = ref.listenManual<PermissionsModel>(
      permissionProvider,
      (_, perms) {
        final haveAllEssentialPermissions = perms.haveUsageAccessPermission &&
            perms.haveDisplayOverlayPermission &&
            perms.haveAlarmsPermission &&
            perms.haveNotificationPermission;

        if (!haveAllEssentialPermissions) return;
        _finishOnboarding();
        _subscription?.close();
      },
    );

    /// Go to permissions page if already done onboarding
    /// but user removed some essential permissions
    Future.delayed(250.ms, _skipToLastPage);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.close();
  }

  void _finishOnboarding() async {
    if (mounted) {
      /// Initialize necessary providers and services
      initializeNecessaryProviders(ref);
      ref.read(mindfulSettingsProvider.notifier).markOnboardingDone();

      Future.delayed(
        150.ms,
        () {
          if (!mounted) return;
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.homeScreen,
            (_) => false,
          );
        },
      );
    }
  }

  void _skipToLastPage() {
    if (mounted && widget.isOnboardingDone) {
      _controller.animateToPage(
        _pages.length - 1,
        duration: _animDuration,
        curve: _animCurve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;
    final perms = ref.watch(permissionProvider);
    final haveAllEssentialPermissions = perms.haveUsageAccessPermission &&
        perms.haveDisplayOverlayPermission &&
        perms.haveAlarmsPermission &&
        perms.haveNotificationPermission;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) => SystemNavigator.pop(),
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   elevation: 0,
        //   scrolledUnderElevation: 0,
        //   toolbarHeight: 0,
        //   backgroundColor: Colors.transparent,
        // ),
        body: Stack(
          children: [
            /// Onboarding Page
            PageView.builder(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemCount: _pages.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _pages[index],
              ),
            ),

            /// Overlay controls
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// Skip button
                    TextButton(
                      onPressed: _skipToLastPage,
                      child: Text(context.locale.onboarding_skip_btn_label),
                    )
                        .animate(target: isLastPage ? 0 : 1)
                        .scale(duration: 100.ms),

                    /// Bottom controls
                    Container(
                      color: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.only(bottom: 32, top: 4),
                      child: Row(
                        children: [
                          /// Page Dots
                          SmoothPageIndicator(
                            controller: _controller,
                            count: _pages.length,
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
                              .scale(duration: 150.ms),
                          4.hBox,

                          isLastPage

                              /// Finish setup
                              ? FilledButton(
                                  onPressed: haveAllEssentialPermissions
                                      ? () => _finishOnboarding()
                                      : null,
                                  child: Text(
                                    context.locale
                                        .onboarding_finish_setup_btn_label,
                                  ),
                                ).animate(target: isLastPage ? 1 : 0).scale(
                                    duration: 250.ms,
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
                                  .scale(duration: 150.ms),

                          /// Finish setup
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
