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
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/controllers/tab_controller_provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverTipsAndTricks extends StatefulWidget {
  const SliverTipsAndTricks({super.key});

  @override
  State<SliverTipsAndTricks> createState() => _SliverTipsAndTricksState();
}

class _SliverTipsAndTricksState extends State<SliverTipsAndTricks> {
  Map<String, void Function(BuildContext context)> getAllTips(
    BuildContext ctx,
  ) =>
      {
        /// Home screen
        ctx.locale.glance_usage_tip: (context) {},
        ctx.locale.notification_blocking_tip: (context) =>
            TabControllerProvider.of(context)
                ?.animateToTab(DefaultHomeTab.notifications.index),
        ctx.locale.usage_history_tip: (context) =>
            TabControllerProvider.of(context)
                ?.animateToTab(DefaultHomeTab.statistics.index),
        ctx.locale.bedtime_reminder_tip: (context) =>
            TabControllerProvider.of(context)
                ?.animateToTab(DefaultHomeTab.bedtime.index),
        ctx.locale.custom_blocking_tip: (context) =>
            TabControllerProvider.of(context)
                ?.animateToTab(DefaultHomeTab.statistics.index),
        ctx.locale.notification_batching_tip: (context) =>
            TabControllerProvider.of(context)
                ?.animateToTab(DefaultHomeTab.notifications.index),
        ctx.locale.notification_scheduling_tip: (context) =>
            TabControllerProvider.of(context)
                ?.animateToTab(DefaultHomeTab.notifications.index),
        ctx.locale.data_usage_tip: (context) =>
            TabControllerProvider.of(context)
                ?.animateToTab(DefaultHomeTab.statistics.index),
        ctx.locale.block_internet_tip: (context) =>
            TabControllerProvider.of(context)
                ?.animateToTab(DefaultHomeTab.statistics.index),
        ctx.locale.emergency_passes_tip: (context) =>
            TabControllerProvider.of(context)
                ?.animateToTab(DefaultHomeTab.bedtime.index),

        /// Settings screen
        ctx.locale.backup_usage_db_tip: (context) => Navigator.of(context)
            .pushNamed(AppRoutes.settingsPath, arguments: {"tab": 1}),
        ctx.locale.dynamic_material_color_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.settingsPath),
        ctx.locale.amoled_dark_theme_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.settingsPath),
        ctx.locale.customize_usage_history_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.settingsPath),
        ctx.locale.battery_optimization_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.settingsPath),

        /// Parental controls screen
        ctx.locale.invincible_mode_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.parentalControlsPath),
        ctx.locale.tamper_protection_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.parentalControlsPath),

        ctx.locale.parental_controls_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.parentalControlsPath),

        /// Focus mode screen
        ctx.locale.focus_mode_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.focusModePath),
        ctx.locale.session_timeline_tip: (context) => Navigator.of(context)
            .pushNamed(AppRoutes.focusModePath, arguments: {"tab": 1}),

        /// Changelogs screen
        ctx.locale.quick_focus_tile_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.changeLogsPath),
        ctx.locale.app_shortcuts_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.changeLogsPath),

        /// Shorts blocking screen
        ctx.locale.accessibility_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.shortsBlockingPath),
        ctx.locale.short_content_blocking_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.shortsBlockingPath),

        /// Websites blocking screen
        ctx.locale.websites_blocking_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.websitesBlockingPath),

        /// Restriction groups screen
        ctx.locale.grouped_apps_blocking_tip: (context) =>
            Navigator.of(context).pushNamed(AppRoutes.restrictionGroupsPath),
      };

  final Map<String, void Function(BuildContext context)> _allTips = {};
  final List<String> _randomTipsKeys = [];

  @override
  void didChangeDependencies() {
    _allTips
      ..clear()
      ..addAll(getAllTips(context));

    _randomTipsKeys
      ..clear()
      ..addAll((_allTips.keys.toList()..shuffle()).take(5));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        const ContentSectionHeader(title: "Tips & Tricks"),

        /// List
        SliverList.builder(
          itemCount: _randomTipsKeys.length,
          itemBuilder: (context, index) {
            final tip = _randomTipsKeys[index];
            final tipParts = _randomTipsKeys[index].split("?");

            return DefaultListTile(
              onPressed: () => _allTips[tip]?.call(context),
              accent: Colors.primaries[index % Colors.primaries.length],
              position: getItemPositionInList(index, _randomTipsKeys.length),
              leadingIcon: FluentIcons.sparkle_20_filled,
              title: RichText(
                text: TextSpan(
                  text: "${tipParts.first}?",
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: tipParts.last,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
