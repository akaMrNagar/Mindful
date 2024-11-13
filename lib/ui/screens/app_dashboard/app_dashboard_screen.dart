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
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/providers/mindful_settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/screens/app_dashboard/emergency_fab.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/sliver_usage_chart_panel.dart';
import 'package:mindful/ui/common/sliver_usage_cards.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/screens/app_dashboard/app_dashboard_restrictions.dart';

class AppDashboardScreen extends ConsumerStatefulWidget {
  /// App dashboard screen containing detailed usage along with quick actions based on the provided app
  const AppDashboardScreen({
    super.key,
    required this.app,
    required this.initialUsageType,
    required this.selectedDoW,
  });

  final AndroidApp app;
  final UsageType initialUsageType;
  final int selectedDoW;

  @override
  ConsumerState<AppDashboardScreen> createState() => _AppDashboardScreenState();
}

class _AppDashboardScreenState extends ConsumerState<AppDashboardScreen> {
  UsageType _selectedUsageType = UsageType.screenUsage;
  int _selectedDoW = todayOfWeek;

  @override
  void initState() {
    super.initState();
    _selectedDoW = widget.selectedDoW;
    _selectedUsageType = widget.initialUsageType;
  }

  void _includeExcludeApp(bool isExcluded) {
    ref.read(mindfulSettingsProvider.notifier).includeExcludeApp(
          widget.app.packageName,
          !isExcluded,
        );

    context.showSnackAlert(
      isExcluded
          ? context.locale.app_include_to_stats_snack_alert(widget.app.name)
          : context.locale.app_excluded_from_stats_snack_alert(widget.app.name),
      icon: isExcluded
          ? FluentIcons.phone_20_filled
          : FluentIcons.phone_dismiss_20_filled,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTimer = ref.watch(appsRestrictionsProvider
            .select((value) => value[widget.app.packageName]?.timerSec)) ??
        0;

    final isPurged =
        appTimer > 0 && appTimer <= widget.app.screenTimeThisWeek[todayOfWeek];

    final isExcludedFromStats = ref.watch(mindfulSettingsProvider
        .select((v) => v.excludedApps.contains(widget.app.packageName)));

    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.data_pie_20_regular,
          filledIcon: FluentIcons.data_pie_20_filled,
          title: context.locale.dashboard_tab_title,
          appBarTitle: widget.app.name,
          fab: const EmergencyFAB(),
          sliverBody: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// App icon and app package name
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// App Icon
                  ApplicationIcon(
                    size: 32,
                    app: widget.app,
                    isGrayedOut: isPurged,
                  ),
                  8.vBox,

                  /// App package name
                  StyledText(
                    widget.app.packageName,
                    color: Theme.of(context).hintColor,
                  ),
                ],
              ).sliver,

              12.vSliverBox,

              /// Usage type selector and usage info card
              SliverUsageCards(
                usageType: _selectedUsageType,
                screenUsageInfo: widget.app.screenTimeThisWeek[_selectedDoW],
                wifiUsageInfo: widget.app.wifiUsageThisWeek[_selectedDoW],
                mobileUsageInfo: widget.app.mobileUsageThisWeek[_selectedDoW],
                onUsageTypeChanged: (type) => setState(
                  () => _selectedUsageType = type,
                ),
              ),

              20.vSliverBox,

              /// Usage bar chart and selected day changer
              SliverUsageChartPanel(
                chartHeight: 212,
                selectedDoW: _selectedDoW,
                usageType: _selectedUsageType,
                barChartData: _selectedUsageType == UsageType.screenUsage
                    ? widget.app.screenTimeThisWeek
                    : widget.app.networkUsageThisWeek,
                onDayOfWeekChanged: (dow) => setState(
                  () => _selectedDoW = dow,
                ),
              ),

              /// Available app setting or functions
              widget.app.packageName == AppConstants.removedAppPackage ||
                      widget.app.packageName == AppConstants.tetheringAppPackage
                  ? StyledText(
                      context
                          .locale.custom_apps_quick_actions_unavailable_warning,
                      fontSize: 14,
                    ).sliver
                  : AppDashboardRestrictions(app: widget.app),

              ContentSectionHeader(title: context.locale.quick_actions_heading)
                  .sliver,

              /// Launch app button
              DefaultListTile(
                position: ItemPosition.start,
                titleText: context.locale.launch_app_tile_title,
                subtitleText:
                    context.locale.launch_app_tile_subtitle(widget.app.name),
                leadingIcon: FluentIcons.open_20_regular,
                onPressed: () async => MethodChannelService.instance
                    .openAppWithPackage(widget.app.packageName),
              ).sliver,

              /// Launch app settings button
              DefaultListTile(
                position: ItemPosition.mid,
                titleText: context.locale.go_to_app_settings_tile_title,
                subtitleText: context.locale.go_to_app_settings_tile_subtitle,
                leadingIcon: FluentIcons.launcher_settings_20_regular,
                onPressed: () async => MethodChannelService.instance
                    .openAppSettingsForPackage(widget.app.packageName),
              ).sliver,

              /// Exclude from usage chart
              DefaultListTile(
                position: ItemPosition.end,
                leadingIcon: isExcludedFromStats
                    ? FluentIcons.phone_dismiss_20_regular
                    : FluentIcons.phone_20_regular,
                switchValue: !isExcludedFromStats,
                titleText: context.locale.include_in_stats_tile_title,
                subtitleText: context.locale.include_in_stats_tile_subtitle,
                accent: isExcludedFromStats
                    ? Theme.of(context).colorScheme.error
                    : null,
                onPressed: () => _includeExcludeApp(isExcludedFromStats),
              ).sliver,

              const SliverTabsBottomPadding(),
            ],
          ),
        ),
      ],
    );
  }
}
