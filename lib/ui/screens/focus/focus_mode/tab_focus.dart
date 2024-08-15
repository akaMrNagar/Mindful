import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/active_session_provider.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/sliver_active_session_alert.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/screens/focus/focus_mode/focus_distracting_apps_list.dart';
import 'package:mindful/ui/screens/focus/focus_mode/focus_configurations.dart';

class TabFocus extends ConsumerStatefulWidget {
  const TabFocus({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabFocusState();
}

class _TabFocusState extends ConsumerState<TabFocus> {
  @override
  void initState() {
    super.initState();
    ref.read(activeSessionProvider.notifier).refreshActiveSessionState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// Appbar
            const SliverFlexibleAppBar(title: "Focus Mode"),

            /// Information
            const StyledText(
              "When you need time to focus, you can pause distracting apps and start do not disturb mode",
            ).sliver,

            const SliverActiveSessionAlert(
              margin: EdgeInsets.only(top: 12),
            ),

            const FocusConfigurations(),

            const FocusDistractingAppsList()
          ],
        ),

        /// FAB
        Positioned(
          bottom: 12,
          right: 12,
          child: FloatingActionButton.extended(
            heroTag: HeroTags.focusModeFABTag,
            icon: const Icon(FluentIcons.target_arrow_20_filled),
            label: const Text("Start Session"),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: _startFocusSession,
          ),
        ),
      ],
    );
  }

  void _startFocusSession() async {
    /// If another focus session is already active
    if (ref.read(activeSessionProvider).value != null) {
      context.showSnackAlert(
        "You already have an active focus session running. Please complete or stop your current session before starting a new one.",
      );
      return;
    }

    // If no distracting apps selected
    final focusMode = ref.read(focusModeProvider);
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
    final newSession =
        await ref.read(activeSessionProvider.notifier).startNewSession(
              durationSeconds: timerSeconds,
              type: focusMode.sessionType,
              toggleDnd: focusMode.shouldStartDnd,
              distractingApps: focusMode.distractingApps,
            );

    if (mounted) {
      Navigator.of(context)
          .pushNamed(AppRoutes.activeSessionScreen, arguments: newSession);
    }
  }
}
