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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/screens/focus/focus_mode/start_session_fab.dart';
import 'package:mindful/ui/screens/focus/focus_mode/tab_focus.dart';
import 'package:mindful/ui/screens/focus/timeline/tab_timeline.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.target_arrow_20_regular,
          filledIcon: FluentIcons.target_arrow_20_filled,
          title: context.locale.focus_tab_title,
          sliverBody: const TabFocus(),
          fab: const StartSessionFAB(),
        ),
        NavbarItem(
          icon: FluentIcons.history_20_regular,
          filledIcon: FluentIcons.history_20_filled,
          title: context.locale.timeline_tab_title,
          sliverBody: const TabTimeline(),
        ),
      ],
    );
  }
}
