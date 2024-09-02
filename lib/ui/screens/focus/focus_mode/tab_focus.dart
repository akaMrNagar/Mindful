/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/sliver_active_session_alert.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
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
    ref.read(focusModeProvider.notifier).refreshActiveSessionState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        const SliverFlexibleAppBar(title: "Focus Mode"),

        /// Information
        const StyledText(
          "When you need time to focus, start a new session by selecting the type, choosing distracting apps to pause, and enabling Do Not Disturb for uninterrupted concentration.",
        ).sliver,

        12.vSliverBox,

        const SliverActiveSessionAlert(
          margin: EdgeInsets.only(top: 12),
        ),

        const FocusConfigurations(),

        const FocusDistractingAppsList(),

        const SliverTabsBottomPadding(),
      ],
    );
  }
}
