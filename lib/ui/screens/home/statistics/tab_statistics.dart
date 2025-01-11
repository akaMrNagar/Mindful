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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/models/usage_filter.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/providers/new/weekly_device_usage_provider.dart';
import 'package:mindful/providers/new/apps_info_provider.dart';
import 'package:mindful/providers/new/filtered_packages_provider.dart';
import 'package:mindful/providers/new/todays_apps_usage_provider.dart';
import 'package:mindful/ui/common/battery_optimization_tip.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/common/sliver_usage_chart_panel.dart';
import 'package:mindful/ui/common/sliver_usage_cards.dart';
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
  UsageFilter _filter = UsageFilter.constant(includeAll: false);
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    /// Aggregated usage for whole week on the basis of full day
    final weeklyUsages =
        ref.watch(weeklyDeviceUsageProvider(_filter.selectedWeek));

    /// Filtered and sorted apps based on usage type and day of this week
    final filteredApps = ref.watch(filteredPackagesProvider(_filter));

    return DefaultRefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoading = true);
        await ref.read(appsInfoProvider.notifier).refreshAppsInfo();
        await ref.read(todaysAppsUsageProvider.notifier).refreshTodaysUsage();

        if (!mounted) return;
        setState(() => _isLoading = false);
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Usage type selector and usage info card
          SliverSkeletonizer.zone(
            enabled: filteredApps.isLoading || _isLoading,
            child: SliverUsageCards(
              usageType: _filter.usageType,
              usage: weeklyUsages[_filter.selectedDay] ?? const UsageModel(),
              onUsageTypeChanged: (type) => setState(
                () => _filter = _filter.copyWith(usageType: type),
              ),
            ),
          ),

          20.vSliverBox,

          /// Usage bar chart and selected day changer
          SliverUsageChartPanel(
            selectedDay: _filter.selectedDay,
            usageType: _filter.usageType,
            barChartData: weeklyUsages,
            onDayOfWeekChanged: (day) =>
                setState(() => _filter = _filter.copyWith(selectedDay: day)),
            onWeekChanged: (day) => setState(
                () => _filter = _filter.copyWith(selectedWeek: day.weekRange)),
          ),

          8.vSliverBox,

          /// Restriction groups
          DefaultListTile(
            position: ItemPosition.top,
            leadingIcon: FluentIcons.app_title_20_regular,
            titleText: context.locale.restriction_groups_tab_title,
            subtitleText: context.locale.restriction_groups_tile_subtitle,
            trailing: const Icon(FluentIcons.chevron_right_20_regular),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            onPressed: () => Navigator.of(context)
                .pushNamed(AppRoutes.restrictionGroupsScreen),
          ).sliver,

          /// Notification batching
          DefaultListTile(
            position: ItemPosition.bottom,
            leadingIcon: FluentIcons.channel_alert_20_regular,
            titleText: context.locale.batch_notifications_tab_title,
            subtitleText: context.locale.batch_notifications_tile_subtitle,
            trailing: const Icon(FluentIcons.chevron_right_20_regular),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            onPressed: () => Navigator.of(context)
                .pushNamed(AppRoutes.batchNotificationsScreen),
          ).sliver,

          ContentSectionHeader(title: context.locale.most_used_apps_heading)
              .sliver,

          const BatteryOptimizationTip(),

          /// Most used apps list
          SliverAnimatedSwitcher(
            duration: AppConstants.defaultAnimDuration,
            switchInCurve: AppConstants.defaultCurve,
            switchOutCurve: AppConstants.defaultCurve.flipped,
            child: filteredApps.hasValue && !_isLoading
                ? SliverImplicitlyAnimatedList<String>(
                    items: filteredApps.value ?? [],
                    animationDurationMultiplier: 1.5,
                    keyBuilder: (item) => item,
                    itemBuilder: (context, package, itemPosition) =>
                        ApplicationTile(
                      packageName: package,
                      usageType: _filter.usageType,
                      selectedDay: _filter.selectedDay,
                      position: itemPosition,
                    ),
                  )
                : const SliverShimmerList(includeSubtitle: true),
          ),

          20.vSliverBox,

          /// Show all apps button
          if (!_filter.includeAll && filteredApps.hasValue)
            DefaultListTile(
              isPrimary: true,
              leading: const Icon(FluentIcons.select_all_off_20_regular),
              titleText: context.locale.show_all_apps_tile_title,
              trailing: const Icon(FluentIcons.chevron_down_20_filled),
              onPressed: () => setState(
                () => _filter = _filter.copyWith(includeAll: true),
              ),
            ).sliver,

          const SliverTabsBottomPadding(),
        ],
      ),
    );
  }
}
