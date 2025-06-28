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
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/controllers/tab_controller_provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverTipsAndTricks extends StatefulWidget {
  const SliverTipsAndTricks({super.key});

  @override
  State<SliverTipsAndTricks> createState() => _SliverTipsAndTricksState();
}

class _SliverTipsAndTricksState extends State<SliverTipsAndTricks> {
  List<MapEntry<String, void Function(BuildContext)>> _randomTips = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => setState(
        () => _randomTips =
            (_buildTips(context).entries.toList()..shuffle()).take(5).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        const ContentSectionHeader(title: "Tips & Tricks"),
        SliverList.builder(
          itemCount: _randomTips.length,
          itemBuilder: (context, index) {
            final tip = _randomTips[index];

            return DefaultListTile(
              onPressed: () => tip.value.call(context),
              position: getItemPositionInList(index, _randomTips.length),
              leading: Icon(
                FluentIcons.sparkle_20_filled,
                color: Colors.primaries[index % Colors.primaries.length],
              ),
              title: StyledText(
                tip.key,
                fontSize: 14,
              ),
            );
          },
        ),
      ],
    );
  }

  Map<String, void Function(BuildContext)> _buildTips(BuildContext ctx) {
    void goToSettings({int? tab}) =>
        Navigator.of(ctx).pushNamed(AppRoutes.settingsPath,
            arguments: tab != null ? {"tab": tab} : null);

    void goToTab(DefaultHomeTab tab) =>
        TabControllerProvider.maybeOf(ctx)?.animateToTab(tab.index);

    return {
      /// Home screen
      ctx.locale.glance_usage_tip: (_) {},
      ctx.locale.notification_blocking_tip: (_) =>
          goToTab(DefaultHomeTab.notifications),
      ctx.locale.usage_history_tip: (_) => goToTab(DefaultHomeTab.statistics),
      ctx.locale.bedtime_reminder_tip: (_) => goToTab(DefaultHomeTab.bedtime),
      ctx.locale.custom_blocking_tip: (_) => goToTab(DefaultHomeTab.statistics),
      ctx.locale.notification_batching_tip: (_) =>
          goToTab(DefaultHomeTab.notifications),
      ctx.locale.notification_scheduling_tip: (_) =>
          goToTab(DefaultHomeTab.notifications),
      ctx.locale.data_usage_tip: (_) => goToTab(DefaultHomeTab.statistics),
      ctx.locale.block_internet_tip: (_) => goToTab(DefaultHomeTab.statistics),
      ctx.locale.emergency_passes_tip: (_) => goToTab(DefaultHomeTab.bedtime),

      /// Settings screen
      ctx.locale.backup_usage_db_tip: (_) => goToSettings(tab: 1),
      ctx.locale.dynamic_material_color_tip: (_) => goToSettings(),
      ctx.locale.amoled_dark_theme_tip: (_) => goToSettings(),
      ctx.locale.customize_usage_history_tip: (_) => goToSettings(),
      ctx.locale.battery_optimization_tip: (_) => goToSettings(),

      /// Parental controls
      ctx.locale.invincible_mode_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.parentalControlsPath),
      ctx.locale.tamper_protection_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.parentalControlsPath),
      ctx.locale.parental_controls_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.parentalControlsPath),

      /// Focus mode
      ctx.locale.focus_mode_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.focusModePath),
      ctx.locale.session_timeline_tip: (_) => Navigator.of(ctx)
          .pushNamed(AppRoutes.focusModePath, arguments: {"tab": 1}),

      /// Changelogs
      ctx.locale.quick_focus_tile_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.changeLogsPath),
      ctx.locale.app_shortcuts_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.changeLogsPath),

      /// Shorts blocking
      ctx.locale.accessibility_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.shortsBlockingPath),
      ctx.locale.short_content_blocking_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.shortsBlockingPath),

      /// Websites blocking
      ctx.locale.websites_blocking_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.websitesBlockingPath),

      /// Restriction groups
      ctx.locale.grouped_apps_blocking_tip: (_) =>
          Navigator.of(ctx).pushNamed(AppRoutes.restrictionGroupsPath),
    };
  }
}
