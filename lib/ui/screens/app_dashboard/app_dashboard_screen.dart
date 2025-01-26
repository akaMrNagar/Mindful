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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/models/app_info.dart';
import 'package:mindful/models/usage_filter_model.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/providers/restrictions/apps_restrictions_provider.dart';
import 'package:mindful/providers/apps/apps_info_provider.dart';
import 'package:mindful/providers/usage/weekly_app_usage_provider.dart';
import 'package:mindful/providers/shared_unique_data_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/scaffold_shell.dart';
import 'package:mindful/ui/common/sliver_usage_cards.dart';
import 'package:mindful/ui/common/sliver_usage_chart_panel.dart';
import 'package:mindful/ui/screens/app_dashboard/emergency_fab.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_restrictions.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppDashboardScreen extends ConsumerStatefulWidget {
  /// App dashboard screen containing detailed usage along with quick actions based on the provided app
  const AppDashboardScreen({
    super.key,
    required this.packageName,
    this.initialUsageType,
    this.selectedDay,
  });

  final String packageName;
  final UsageType? initialUsageType;
  final DateTime? selectedDay;

  @override
  ConsumerState<AppDashboardScreen> createState() => _AppDashboardScreenState();
}

class _AppDashboardScreenState extends ConsumerState<AppDashboardScreen> {
  late UsageFilterModel _filter = UsageFilterModel(
    selectedDay: widget.selectedDay ?? dateToday,
    selectedWeek: (widget.selectedDay ?? dateToday).weekRange,
    usageType: widget.initialUsageType ?? UsageType.screenUsage,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.packageName.isEmpty) {
        Navigator.of(context).maybePop();
      }
    });
  }

  void _includeExcludeApp(String appName, bool isExcluded) {
    ref.read(sharedUniqueDataProvider.notifier).includeExcludeApp(
          widget.packageName,
          !isExcluded,
        );

    context.showSnackAlert(
      isExcluded
          ? context.locale.app_include_to_stats_snack_alert(appName)
          : context.locale.app_excluded_from_stats_snack_alert(appName),
      icon: isExcluded
          ? FluentIcons.phone_20_filled
          : FluentIcons.phone_dismiss_20_filled,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appInfo = ref.watch(
            appsInfoProvider.select((v) => v.value?[widget.packageName])) ??
        AppInfo.placeHolder(widget.packageName);

    final weeklyUsages = ref.watch(
        weeklyAppUsageProvider((widget.packageName, _filter.selectedWeek)));

    final appTimer = ref.watch(appsRestrictionsProvider
            .select((value) => value[widget.packageName]?.timerSec)) ??
        0;

    final isPurged =
        appTimer > 0 && appTimer <= (weeklyUsages[dateToday]?.screenTime ?? 0);

    final isExcludedFromStats = ref.watch(sharedUniqueDataProvider
        .select((v) => v.excludedApps.contains(widget.packageName)));

    final isNetworkOnlyApp =
        widget.packageName == AppConstants.removedAppPackage ||
            widget.packageName == AppConstants.tetheringAppPackage;

    return Skeletonizer.zone(
      enabled: appInfo.name.isEmpty,
      ignorePointers: false,
      child: ScaffoldShell(
        appBarExpandedHeight: 220,
        items: [
          NavbarItem(
            icon: FluentIcons.data_pie_20_regular,
            filledIcon: FluentIcons.data_pie_20_filled,
            titleText: appInfo.name.isEmpty
                ? context.locale.dashboard_tab_title
                : appInfo.name,
            fab: const EmergencyFAB(),
            titleBuilder: (percentage) =>
                _buildTitle(percentage, appInfo, isPurged),
            sliverBody: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                /// Usage type selector and usage info card
                SliverUsageCards(
                  usage:
                      weeklyUsages[_filter.selectedDay] ?? const UsageModel(),
                  usageType: _filter.usageType,
                  onUsageTypeChanged: (type) => setState(
                    () => _filter = _filter.copyWith(usageType: type),
                  ),
                ),

                20.vSliverBox,

                /// Usage bar chart and selected day changer
                SliverUsageChartPanel(
                  chartHeight: 212,
                  selectedDay: _filter.selectedDay,
                  usageType: _filter.usageType,
                  barChartData: weeklyUsages,
                  onDayOfWeekChanged: (day) => setState(
                      () => _filter = _filter.copyWith(selectedDay: day)),
                  onWeekChanged: (day) => setState(() =>
                      _filter = _filter.copyWith(selectedWeek: day.weekRange)),
                ),

                /// Available app setting or functions
                isNetworkOnlyApp
                    ? StyledText(
                        context.locale
                            .custom_apps_quick_actions_unavailable_warning,
                        fontSize: 14,
                      ).sliver
                    : AppDashboardRestrictions(
                        appInfo: appInfo,
                        appTimer: appTimer,
                        isPurged: isPurged,
                      ),

                ContentSectionHeader(
                  title: context.locale.quick_actions_heading,
                ).sliver,

                /// Launch app button
                DefaultListTile(
                  position: ItemPosition.top,
                  titleText: context.locale.launch_app_tile_title,
                  subtitleText:
                      context.locale.launch_app_tile_subtitle(appInfo.name),
                  leadingIcon: FluentIcons.open_20_regular,
                  onPressed: () async => MethodChannelService.instance
                      .openAppWithPackage(widget.packageName),
                ).sliver,

                /// Launch app settings button
                DefaultListTile(
                  position: ItemPosition.mid,
                  titleText: context.locale.go_to_app_settings_tile_title,
                  subtitleText: context.locale.go_to_app_settings_tile_subtitle,
                  leadingIcon: FluentIcons.launcher_settings_20_regular,
                  onPressed: () async => MethodChannelService.instance
                      .openAppSettingsForPackage(widget.packageName),
                ).sliver,

                /// Exclude from usage chart
                DefaultListTile(
                  enabled: !isNetworkOnlyApp,
                  position: ItemPosition.bottom,
                  leadingIcon: isExcludedFromStats
                      ? FluentIcons.phone_dismiss_20_regular
                      : FluentIcons.phone_20_regular,
                  switchValue: !isExcludedFromStats,
                  titleText: context.locale.include_in_stats_tile_title,
                  subtitleText: context.locale.include_in_stats_tile_subtitle,
                  accent: isExcludedFromStats
                      ? Theme.of(context).colorScheme.error
                      : null,
                  onPressed: () => _includeExcludeApp(
                    appInfo.name,
                    isExcludedFromStats,
                  ),
                ).sliver,

                const SliverTabsBottomPadding(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildTitle(
    double percentage,
    AppInfo appInfo,
    bool isPurged,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// App icon
        Opacity(
          opacity: percentage,
          child: ApplicationIcon(
            size: 16 * percentage,
            appInfo: appInfo,
            isGrayedOut: isPurged,
          ),
        ),
        4.vBox,

        /// App name
        AppBarTitle(
          titleText: appInfo.name.isEmpty
              ? context.locale.dashboard_tab_title
              : appInfo.name,
        ),

        /// App package
        Opacity(
          opacity: percentage,
          child: StyledText(
            widget.packageName,
            color: Theme.of(context).hintColor,
            fontSize: 8 * percentage,
          ),
        ),
      ],
    );
  }
}
