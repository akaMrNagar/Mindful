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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/utils/provider_utils.dart';
import 'package:mindful/models/usage_filter_model.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/providers/usage/weekly_device_usage_provider.dart';
import 'package:mindful/providers/apps/apps_info_provider.dart';
import 'package:mindful/providers/apps/filtered_packages_provider.dart';
import 'package:mindful/providers/usage/todays_apps_usage_provider.dart';
import 'package:mindful/ui/common/accessibility_tip.dart';
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
  UsageFilterModel _filter = UsageFilterModel.constant(includeAll: false);
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

        /// Refresh apps info and todays usage
        ref.read(appsInfoProvider.notifier).refreshAppsInfo();
        await ref.read(todaysAppsUsageProvider.notifier).refreshTodaysUsage();

        if (!mounted) return;
        setState(() => _isLoading = false);
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Usage type selector and usage info card
          SliverSkeletonizer.zone(
            enabled: _isLoading,
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
            selectedWeek: _filter.selectedWeek,
            usageType: _filter.usageType,
            barChartData: _isLoading
                ? generateEmptyWeekUsage(_filter.selectedDay)
                : weeklyUsages,
            onDayOfWeekChanged: (day) =>
                setState(() => _filter = _filter.copyWith(selectedDay: day)),
            onWeekChanged: (day) => setState(
                () => _filter = _filter.copyWith(selectedWeek: day.weekRange)),
          ),

          Row(
            children: [
              ContentSectionHeader(
                title: context.locale.most_used_apps_heading,
              ),

              const Spacer(),

              /// Current day
              ContentSectionHeader(
                title: _filter.selectedDay.dateString(context),
              ),
            ],
          ).sliver,

          const AccessibilityTip(),
          const BatteryOptimizationTip(),

          /// Most used apps list
          SliverAnimatedSwitcher(
            duration: AppConstants.defaultAnimDuration,
            switchInCurve: AppConstants.defaultCurve,
            switchOutCurve: AppConstants.defaultCurve.flipped,
            child: filteredApps.isLoading
                ? const SliverShimmerList(includeSubtitle: true)
                : SliverImplicitlyAnimatedList<String>(
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
                  ),
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
