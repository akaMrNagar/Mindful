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

class StartSessionFAB extends ConsumerWidget {
  const StartSessionFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      heroTag: HeroTags.focusModeFABTag,
      icon: const Icon(FluentIcons.target_arrow_20_filled),
      label: Text(context.locale.focus_session_start_fab_button),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: () => _startFocusSession(context, ref),
    );
  }

  void _startFocusSession(BuildContext context, WidgetRef ref) async {
    final focusModeModel = ref.read(focusModeProvider);

    /// If another focus session is already active
    if (focusModeModel.activeSession != null) {
      context.showSnackAlert(
        context.locale.focus_session_already_active_snack_alert,
      );
      return;
    }

    // If no distracting apps selected
    if (focusModeModel.focusProfile.distractingApps.isEmpty) {
      context.showSnackAlert(
        context.locale.focus_session_minimum_apps_snack_alert,
      );
      return;
    }

    final newSession = await ref
        .read(focusModeProvider.notifier)
        .startNewSession();

    await Future.delayed(300.ms);
    if (context.mounted) {
      Navigator.of(context).pushNamed(
        AppRoutes.activeSessionScreen,
        arguments: newSession,
      );
    }
  }
}
