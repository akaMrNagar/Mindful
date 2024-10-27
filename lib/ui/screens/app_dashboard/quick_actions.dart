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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/app_dashboard/app_internet_switcher.dart';
import 'package:mindful/ui/screens/app_dashboard/app_timer_picker.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// Displays available actions for the app in [AppDashboard]
class QuickActions extends ConsumerWidget {
  const QuickActions({super.key, required this.app});

  final AndroidApp app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiSliver(
      children: [
        const SliverContentTitle(title: "Restrictions"),

        /// App Timer tile
        AppTimerPicker(app: app).sliver,

        /// App launch limit
        DefaultListTile(
          titleText: "App launch limit",
          subtitleText: "Launched 15 times today.",
          leadingIcon: FluentIcons.rocket_20_regular,
          trailing: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: StyledText("30", fontSize: 16),
          ),
          onPressed: () {},
        ).sliver,

        /// App launch limit
        DefaultListTile(
          titleText: "Session & Cooldown limit",
          subtitleText: "Use for 1h 30m and wait for 2h 45m.",
          leadingIcon: FluentIcons.shifts_availability_20_regular,
          onPressed: () {},
        ).sliver,

        /// Associated restriction group
        DefaultListTile(
          titleText: "Social",
          subtitleText: "Associated restriction group.",
          leadingIcon: FluentIcons.app_title_20_regular,
          trailing: const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: () {},
        ).sliver,

        /// Internet access
        AppInternetSwitcher(app: app).sliver,
      ],
    );
  }
}
