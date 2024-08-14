import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/screens/focus/focus_mode/focus_distracting_apps_list.dart';
import 'package:mindful/ui/screens/focus/focus_mode/focus_configurations.dart';

class TabFocus extends StatelessWidget {
  const TabFocus({super.key});

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

            const FocusConfigurations(),

            const FocusDistractingAppsList()
          ],
        ),

        /// FAB
        Positioned(
          bottom: 12,
          right: 12,
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              return FloatingActionButton.extended(
                heroTag: HeroTags.focusModeFABTag,
                label: const Text("Start Session"),
                icon: const Icon(FluentIcons.target_arrow_20_filled),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                onPressed: () => _startFocusSession(context, ref),
              );
            },
          ),
        ),
      ],
    );
  }

  void _startFocusSession(BuildContext context, WidgetRef ref) async {
    /// Check if already session is running then forward to active session screen
    final state = ref.read(focusModeProvider);
    if (state.lastSession != null) {
      Navigator.of(context).pushNamed(AppRoutes.activeSessionScreen);
      return;
    }

    // If no distracting apps selected
    if (state.distractingApps.isEmpty) {
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
    if (timerSeconds == null) return;
    await ref.read(focusModeProvider.notifier).startNewSession(timerSeconds);

    /// Return if not mounted
    if (!context.mounted) return;
    Navigator.of(context).pushNamed(AppRoutes.activeSessionScreen);
  }
}
