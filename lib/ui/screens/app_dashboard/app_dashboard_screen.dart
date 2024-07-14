import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';
import 'package:mindful/ui/common/sliver_usage_chart_panel.dart';
import 'package:mindful/ui/common/sliver_usage_cards.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/screens/app_dashboard/quick_actions.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// Provides usage type for toggling between usages charts
final _selectedUsageTypeProvider =
    StateProvider<UsageType>((ref) => UsageType.screenUsage);

/// Provides int which is the selected day of week on bar chart
final _selectedDayOfWeekProvider = StateProvider<int>((ref) => dayOfWeek);

class AppDashboardScreen extends ConsumerWidget {
  const AppDashboardScreen({
    super.key,
    required this.app,
  });

  final AndroidApp app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayOfWeek = ref.watch(_selectedDayOfWeekProvider);
    final usageType = ref.watch(_selectedUsageTypeProvider);
    final haveVpnPermission =
        ref.watch(permissionProvider.select((v) => v.haveVpnPermission));

    return Scaffold(
      body: DefaultNavbar(
        navbarItems: [
          NavbarItem(
            icon: FluentIcons.data_pie_20_filled,
            title: "Dashboard",
            body: Padding(
              padding: const EdgeInsets.only(left: 4, right: 12),
              child: CustomScrollView(
                slivers: [
                  /// App bar
                  SliverFlexibleAppBar(title: app.name),

                  /// App icon and app package name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// App Icon
                      ApplicationIcon(app: app, size: 32),
                      8.vBox(),

                      /// App package name
                      StyledText(
                        app.packageName,
                        color: Theme.of(context).hintColor,
                      ),
                      8.vBox(),
                    ],
                  ).toSliverBox(),

                  /// Usage type selector and usage info card
                  SliverUsageCards(
                    usageType: usageType,
                    screenUsageInfo: app.screenTimeThisWeek[dayOfWeek],
                    wifiUsageInfo: app.wifiUsageThisWeek[dayOfWeek],
                    mobileUsageInfo: app.mobileUsageThisWeek[dayOfWeek],
                    onUsageTypeChanged: (i) => ref
                        .read(_selectedUsageTypeProvider.notifier)
                        .update((_) => UsageType.values[i]),
                  ),

                  20.vSliverBox(),

                  /// Usage bar chart and selected day changer
                  SliverUsageChartPanel(
                    chartHeight: 212,
                    dayOfWeek: dayOfWeek,
                    usageType: usageType,
                    barChartData: usageType == UsageType.screenUsage
                        ? app.screenTimeThisWeek
                        : app.networkUsageThisWeek,
                    onDayOfWeekChanged: (dow) => ref
                        .read(_selectedDayOfWeekProvider.notifier)
                        .update((_) => dow),
                  ),

                  const SliverContentTitle(title: "Quick actions"),

                  /// Available app setting or functions
                  app.packageName == AppConstants.removedAppPackage ||
                          app.packageName == AppConstants.tetheringAppPackage
                      ? const StyledText(
                          "Screen usage and quick actions are currently unavailable for this application. At present, only network usage is accessible",
                          fontSize: 14,
                        ).toSliverBox()
                      : MultiSliver(
                          children: [
                            /// Quick action for app
                            QuickActions(app: app),

                            /// Vpn persmission
                            SliverPermissionWarning(
                              title: "Create VPN",
                              information:
                                  "Granting permission to establish a local virtual private network (VPN) connection enables Mindful to restrict internet access for designated applications.",
                              havePermission: haveVpnPermission,
                              margin: const EdgeInsets.only(top: 24),
                              onTapAllow: ref
                                  .read(permissionProvider.notifier)
                                  .askVpnPermission,
                            ),
                          ],
                        ),

                  120.vSliverBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
