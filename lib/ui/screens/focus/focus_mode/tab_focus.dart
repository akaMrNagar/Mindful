/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/sliver_active_session_alert.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/focus/focus_mode/focus_distracting_apps_list.dart';
import 'package:mindful/ui/screens/focus/focus_mode/focus_configurations.dart';

class TabFocus extends StatelessWidget {
  const TabFocus({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        SliverFlexibleAppBar(title: context.locale.focus_tab_title),

        /// Information
        StyledText(context.locale.focus_tab_info).sliver,

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
