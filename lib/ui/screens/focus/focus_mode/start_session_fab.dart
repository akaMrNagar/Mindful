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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/providers/focus/focus_mode_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:slide_action/slide_action.dart';

class StartSessionFAB extends ConsumerWidget {
  const StartSessionFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FractionallySizedBox(
          widthFactor: 0.5,
          child: DefaultHero(
            tag: HeroTags.focusModeFABTag,
            child: SlideAction(
              trackHeight: 52,
              actionSnapThreshold: 0.9,
              trackBuilder: (context, currentState) => RoundedContainer(
                color: Theme.of(context).colorScheme.primary,
                circularRadius: 16,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: StyledText(
                    context.locale.focus_session_start_fab_button,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              thumbBuilder: (context, currentState) => RoundedContainer(
                color: Theme.of(context).colorScheme.primaryContainer,
                margin: EdgeInsets.all(4),
                circularRadius: 14,
                child: Icon(
                  FluentIcons.chevron_right_20_filled,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              action: () => _startFocusSession(context, ref),
            ).animate().scale(
                  duration: AppConstants.defaultAnimDuration,
                  curve: Curves.easeOutBack,
                  alignment: Alignment.bottomRight,
                ),
          ),
        ),
      ],
    );
  }

  void _startFocusSession(BuildContext context, WidgetRef ref) async {
    final focusMode = ref.read(focusModeProvider);

    /// If another focus session is already active
    if (focusMode.activeSession.value != null) {
      context.showSnackAlert(
        context.locale.focus_session_already_active_snack_alert,
      );
      return;
    }

    // If no distracting apps selected
    if (focusMode.focusProfile.distractingApps.isEmpty) {
      context.showSnackAlert(
        context.locale.focus_session_minimum_apps_snack_alert,
      );
      return;
    }

    await ref.read(focusModeProvider.notifier).startNewSession();

    await Future.delayed(300.ms);
    if (context.mounted) {
      Navigator.of(context).pushNamed(AppRoutes.activeSessionPath);
    }
  }
}
