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
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';

class StartSessionFAB extends ConsumerWidget {
  const StartSessionFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      heroTag: HeroTags.focusModeFABTag,
      icon: const Icon(FluentIcons.target_arrow_20_filled),
      label: const Text("Start Session"),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: () => _startFocusSession(context, ref),
    );
  }

  void _startFocusSession(BuildContext context, WidgetRef ref) async {
    final focusMode = ref.read(focusModeProvider);

    /// If another focus session is already active
    if (focusMode.activeSession != null) {
      context.showSnackAlert(
        "You already have an active focus session running. Please complete or stop your current session before starting a new one.",
      );
      return;
    }

    // If no distracting apps selected
    if (focusMode.distractingApps.isEmpty) {
      context.showSnackAlert(
        "Select at least one distracting app to start focus session",
      );
      return;
    }

    final timerSeconds = await showFocusTimerPicker(
      context: context,
      heroTag: HeroTags.focusModeFABTag,
    );

    /// Return if user cancelled duration picker
    if (timerSeconds == null || timerSeconds <= 0) return;
    final newSession = await ref
        .read(focusModeProvider.notifier)
        .startNewSession(durationSeconds: timerSeconds);

    await Future.delayed(300.ms);
    if (context.mounted) {
      Navigator.of(context)
          .pushNamed(AppRoutes.activeSessionScreen, arguments: newSession);
    }
  }
}
