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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/aggregated_usage_stats_provider.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/packages_by_network_usage_provider.dart';
import 'package:mindful/providers/packages_by_screen_usage_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_usage_chart_panel.dart';
import 'package:mindful/ui/common/sliver_usage_cards.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/screens/home/statistics/application_tile.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TabStatistics extends ConsumerStatefulWidget {
  const TabStatistics({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabStatisticsState();
}

class _TabStatisticsState extends ConsumerState<TabStatistics> {
  UsageType _usageType = UsageType.screenUsage;
  int _selectedDayOfWeek = todayOfWeek;
  bool _includeAllApps = false;

  @override
  Widget build(BuildContext context) {
    /// Aggregated usage for whole week on the basis of full day
    final aggregatedUsage = ref.watch(aggregatedUsageStatsProvider);

    /// Arguments for family provider
    final args = (selectedDoW: _selectedDayOfWeek, includeAll: _includeAllApps);

    /// Filtered and sorted apps based on usage type and day of this week
    final filteredApps = _usageType == UsageType.screenUsage
        ? ref.watch(packagesByScreenUsageProvider(args))
        : ref.watch(packagesByNetworkUsageProvider(args));

    return DefaultRefreshIndicator(
      onRefresh: ref.read(appsProvider.notifier).refreshDeviceApps,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "Statistics"),

          /// Usage type selector and usage info card
          SliverSkeletonizer.zone(
            enabled: !filteredApps.hasValue,
            child: SliverUsageCards(
              usageType: _usageType,
              screenUsageInfo:
                  aggregatedUsage.screenTimeThisWeek[_selectedDayOfWeek],
              wifiUsageInfo:
                  aggregatedUsage.wifiUsageThisWeek[_selectedDayOfWeek],
              mobileUsageInfo:
                  aggregatedUsage.mobileUsageThisWeek[_selectedDayOfWeek],
              onUsageTypeChanged: (type) => setState(() => _usageType = type),
            ),
          ),
          20.vSliverBox,

          /// Usage bar chart and selected day changer
          SliverUsageChartPanel(
            selectedDoW: _selectedDayOfWeek,
            usageType: _usageType,
            barChartData: _usageType == UsageType.screenUsage
                ? aggregatedUsage.screenTimeThisWeek
                : aggregatedUsage.networkUsageThisWeek,
            onDayOfWeekChanged: (dow) =>
                setState(() => _selectedDayOfWeek = dow),
          ),

          const SliverContentTitle(title: "Most used apps"),

          /// Most used apps list
          SliverAnimatedSwitcher(
            duration: 300.ms,
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: filteredApps.hasValue
                ? AnimatedAppsList(
                    itemExtent: 64,
                    appPackages: filteredApps.value ?? [],
                    itemBuilder: (context, app) => ApplicationTile(
                      app: app,
                      selectedUsageType: _usageType,
                      selectedDoW: _selectedDayOfWeek,
                    ),
                  )
                : const SliverShimmerList(includeSubtitle: true),
          ),

          /// Show all apps button
          if (!_includeAllApps && filteredApps.hasValue)
            DefaultListTile(
              height: 48,
              isPrimary: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.only(top: 20),
              leading: const Icon(FluentIcons.select_all_off_20_regular),
              titleText: "Show all apps",
              trailing: const Icon(FluentIcons.chevron_down_20_filled),
              onPressed: () => setState(() => _includeAllApps = true),
            ).sliver,

          const SliverTabsBottomPadding(),
        ],
      ),
    );
  }
}
