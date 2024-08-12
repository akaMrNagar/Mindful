import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/utils/tags.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/screens/focus/focus_setup.dart';
import 'package:mindful/ui/screens/focus/running_timer.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  bool _isSessionActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isSessionActive
          ? null
          : FloatingActionButton.extended(
              heroTag: AppTags.focusModeFABTag,
              label: const Text("Start Now"),
              icon: const Icon(FluentIcons.target_arrow_20_filled),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () => _startFocusSession(context),
            ),
      body: DefaultNavbar(
        navbarItems: [
          NavbarItem(
            icon: FluentIcons.target_arrow_20_filled,
            title: "Focus",
            body: Padding(
              padding: const EdgeInsets.only(left: 4, right: 8),
              child: AnimatedSwitcher(
                duration: 300.ms,
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeOut,
                child: _isSessionActive
                    ? const RunningTimer()
                    : const FocusSetup(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startFocusSession(BuildContext context) async {
    final timerSeconds = await showFocusTimerPicker(
      context: context,
      heroTag: AppTags.focusModeFABTag,
    );
    if (timerSeconds == null || !context.mounted) return;

    setState(() {
      _isSessionActive = true;
    });
  }
}
