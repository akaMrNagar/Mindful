import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/ui/common/components/usage_chart_panel.dart';
import 'package:mindful/ui/common/components/usage_cards_sliver.dart';
import 'package:mindful/ui/common/components/flexible_appbar.dart';
import 'package:mindful/ui/common/components/persistent_header.dart';
import 'package:mindful/ui/common/vertical_tab_bar.dart';
import 'package:mindful/ui/common/components/application_icon.dart';
import 'package:mindful/ui/common/custom_text.dart';
import 'package:mindful/ui/screens/app_dashboard/app_settings.dart';

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

    return Scaffold(
      body: VerticalTabBar(
        tabItems: [
          VerticalTabItem(
            icon: FluentIcons.data_pie_20_filled,
            title: "Dashboard",
            body: Padding(
              padding: const EdgeInsets.only(left: 4, right: 12),
              child: CustomScrollView(
                slivers: [
                  /// App bar
                  FlexibleAppBar(
                    title: app.name,
                    canCollapse: false,
                  ),

                  /// App icon and app package name
                  SliverPersistentHeader(
                    delegate: PersistentHeader(
                      maxHeight: 96,
                      minHeight: 96,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// App Icon
                          ApplicationIcon(app: app, size: 32),
                          4.vBox(),

                          /// App package name
                          SubtitleText(app.packageName),
                        ],
                      ),
                    ),
                  ),

                  /// Usage type selector and usage info card
                  UsageCardsSliver(
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
                  UsageChartPanel(
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

                  /// Available app setting or functions
                  if (app.packageName != Constants.removedAppPackage &&
                      app.packageName != Constants.tetheringAppPackage)
                    AppSettings(app: app),

                  560.vSliverBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
