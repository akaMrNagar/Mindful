import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/sliver_usage_chart_panel.dart';
import 'package:mindful/ui/common/sliver_usage_cards.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/permissions/vpn_permission.dart';
import 'package:mindful/ui/screens/app_dashboard/quick_actions.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AppDashboardScreen extends StatefulWidget {
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
  State<AppDashboardScreen> createState() => _AppDashboardScreenState();
}

class _AppDashboardScreenState extends State<AppDashboardScreen> {
  UsageType _selectedUsageType = UsageType.screenUsage;
  int _selectedDoW = todayOfWeek;

  @override
  void initState() {
    super.initState();

    setState(() {
      _selectedDoW = widget.selectedDoW;
      _selectedUsageType = widget.initialUsageType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultNavbar(
        navbarItems: [
          NavbarItem(
            icon: FluentIcons.data_pie_20_filled,
            title: "Dashboard",
            body: Padding(
              padding: const EdgeInsets.only(left: 4, right: 12),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  /// App bar
                  SliverFlexibleAppBar(title: widget.app.name),

                  /// App icon and app package name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// App Icon
                      ApplicationIcon(app: widget.app, size: 32),
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
                    screenUsageInfo:
                        widget.app.screenTimeThisWeek[_selectedDoW],
                    wifiUsageInfo: widget.app.wifiUsageThisWeek[_selectedDoW],
                    mobileUsageInfo:
                        widget.app.mobileUsageThisWeek[_selectedDoW],
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

                  const SliverContentTitle(title: "Quick actions"),

                  /// Available app setting or functions
                  widget.app.packageName == AppConstants.removedAppPackage ||
                          widget.app.packageName ==
                              AppConstants.tetheringAppPackage
                      ? const StyledText(
                          "Screen usage and quick actions are currently unavailable for this application. At present, only network usage is accessible",
                          fontSize: 14,
                        ).sliver
                      : MultiSliver(
                          children: [
                            /// Vpn permission
                            if (!widget.app.isImpSysApp) const VpnPermission(),

                            /// Quick action for app
                            QuickActions(app: widget.app),
                          ],
                        ),

                  const SliverTabsBottomPadding(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
