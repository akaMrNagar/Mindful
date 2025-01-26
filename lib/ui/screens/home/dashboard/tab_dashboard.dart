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
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/usage/todays_apps_usage_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_active_session_alert.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/tab_controller_provider.dart';
import 'package:mindful/ui/screens/home/dashboard/glance_cards/focus_daily_glance.dart';
import 'package:mindful/ui/screens/home/dashboard/glance_cards/screen_time_glance.dart';
import 'package:mindful/ui/screens/home/dashboard/glance_cards_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TabDashboard extends ConsumerWidget {
  const TabDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultRefreshIndicator(
      onRefresh: ref.read(todaysAppsUsageProvider.notifier).refreshTodaysUsage,
      child: Skeletonizer.zone(
        enabled: false,
        // enabled: ref.read(appsProvider).isLoading,
        // enableSwitchAnimation: true,
        ignorePointers: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// Active session
            const SliverActiveSessionAlert(),

            MultiSliver(
              children: [
                Row(
                  children: [
                    /// Screen time
                    const Expanded(child: ScreenTimeGlance()),
                    4.hBox,

                    /// Data usage
                    const Expanded(child: FocusDailyGlance()),
                  ],
                ),

                /// Usage glance
                DefaultExpandableListTile(
                  position: ItemPosition.mid,
                  titleText: context.locale.glance_tile_title,
                  subtitleText: context.locale.glance_tile_subtitle,
                  content: const GlanceCardsGrid(),
                ),

                /// Parental controls
                DefaultListTile(
                  position: ItemPosition.bottom,
                  leadingIcon: FluentIcons.shield_keyhole_20_regular,
                  titleText: context.locale.parental_controls_tab_title,
                  subtitleText: context.locale.parental_controls_tile_subtitle,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  trailing: const Icon(FluentIcons.chevron_right_20_regular),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.parentalControlsScreen),
                ),

                /// Restrictions
                ContentSectionHeader(
                  title: context.locale.restrictions_heading,
                ),

                /// Apps blocking
                DefaultListTile(
                  position: ItemPosition.top,
                  leadingIcon: FluentIcons.app_title_20_regular,
                  titleText: context.locale.apps_blocking_tile_title,
                  subtitleText: context.locale.apps_blocking_tile_subtitle,
                  onPressed: () =>
                      TabControllerProvider.of(context)?.animateToTab(
                    DefaultHomeTab.statistics.index,
                  ),
                ),

                /// Grouped apps blocking
                DefaultListTile(
                  position: ItemPosition.mid,
                  leadingIcon: FluentIcons.app_recent_20_regular,
                  titleText: context.locale.grouped_apps_blocking_tile_title,
                  subtitleText:
                      context.locale.grouped_apps_blocking_tile_subtitle,
                  trailing: const Icon(FluentIcons.chevron_right_20_regular),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.restrictionGroupsScreen),
                ),

                /// Shorts restrictions
                DefaultListTile(
                  position: ItemPosition.mid,
                  leadingIcon: FluentIcons.resize_video_20_regular,
                  titleText: context.locale.shorts_blocking_tile_title,
                  subtitleText: context.locale.shorts_blocking_tile_subtitle,
                  trailing: const Icon(FluentIcons.chevron_right_20_regular),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.shortsBlockingScreen),
                ),

                /// Website restrictions
                DefaultListTile(
                  position: ItemPosition.bottom,
                  leadingIcon: FluentIcons.earth_20_regular,
                  titleText: context.locale.websites_blocking_tile_title,
                  subtitleText: context.locale.websites_blocking_tile_subtitle,
                  trailing: const Icon(FluentIcons.chevron_right_20_regular),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.websitesBlockingScreen),
                ),
              ],
            ),

            const SliverTabsBottomPadding(),
          ],
        ),
      ),
    );
  }
}
