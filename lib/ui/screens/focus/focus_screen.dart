import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/screens/focus/focus_mode/tab_focus.dart';
import 'package:mindful/ui/screens/focus/timeline/tab_timeline.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  final int initialTabIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultNavbar(
        initialTabIndex: initialTabIndex,
        navbarItems: const [
          NavbarItem(
            icon: FluentIcons.target_arrow_20_filled,
            title: "Focus",
            body: TabFocus(),
          ),
          NavbarItem(
            icon: FluentIcons.history_20_filled,
            title: "Timeline",
            body: TabTimeline(),
          ),
        ],
      ),
    );
  }
}
