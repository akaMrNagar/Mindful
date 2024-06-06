import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/aggregated_usage_provider.dart';
import 'package:mindful/ui/common/usage_chart_panel.dart';
import 'package:mindful/ui/common/usage_cards_sliver.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/screens/home/dashboard/application_tile.dart';

/// Provides usage type for toggling between usages charts
final _selectedUsageTypeProvider =
    StateProvider<UsageType>((ref) => UsageType.screenUsage);

/// Provides int which is the selected day of week on bar chart
final _selectedDayOfWeekProvider = StateProvider<int>((ref) => dayOfWeek);

class TabDashboard extends ConsumerWidget {
  const TabDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Refreshhed");
    final aggregatedUsage = ref.watch(aggregatedUsageProvider);
    final dayOfWeek = ref.watch(_selectedDayOfWeekProvider);
    final usageType = ref.watch(_selectedUsageTypeProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: CustomScrollView(
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "Dashboard"),

          /// Usage type selector and usage info card
          UsageCardsSliver(
            usageType: usageType,
            screenUsageInfo: aggregatedUsage.screenTimeThisWeek[dayOfWeek],
            wifiUsageInfo: aggregatedUsage.wifiUsageThisWeek[dayOfWeek],
            mobileUsageInfo: aggregatedUsage.mobileUsageThisWeek[dayOfWeek],
            onUsageTypeChanged: (i) => ref
                .read(_selectedUsageTypeProvider.notifier)
                .update((_) => UsageType.values[i]),
          ),
          20.vSliverBox(),

          /// Usage bar chart and selected day changer
          UsageChartPanel(
            dayOfWeek: dayOfWeek,
            usageType: usageType,
            barChartData: usageType == UsageType.screenUsage
                ? aggregatedUsage.screenTimeThisWeek
                : aggregatedUsage.networkUsageThisWeek,
            onDayOfWeekChanged: (dow) => ref
                .read(_selectedDayOfWeekProvider.notifier)
                .update((_) => dow),
          ),

          /// Most used apps list
          AnimatedAppsList(
            usageType: usageType,
            selectedDoW: dayOfWeek,
            itemExtent: 64,
            listLabel: "Most used apps",
            itemBuilder: (context, appPackage) => ApplicationTile(
              appPackage: appPackage,
              usageType: usageType,
              day: dayOfWeek,
            ),
          ),

          72.vSliverBox(),
        ],
      ),
    );
  }
}
