import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/aggregated_usage_provider.dart';
import 'package:mindful/providers/sorted_apps_provider.dart';
import 'package:mindful/ui/common/persistent_header.dart';
import 'package:mindful/ui/common/flexible_appbar.dart';
import 'package:mindful/ui/screens/home/dashboard/animated_apps_list.dart';
import 'package:mindful/ui/common/components/segmented_icon_buttons.dart';
import 'package:mindful/ui/common/base_bar_chart.dart';
import 'package:mindful/ui/common/usage_info_cards.dart';

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
      padding: const EdgeInsets.only(left: 4, right: 12),
      child: CustomScrollView(
        slivers: [
          /// Appbar
          const FlexibleAppBar(title: "Dashboard"),

          /// Usage type selector and usage info card
          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeader(
              maxHeight: 120,
              minHeight: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Usage type selector
                  SegmentedIconButton(
                    selected: usageType.index,
                    segments: const [
                      FluentIcons.phone_screen_time_20_regular,
                      FluentIcons.earth_20_regular,
                    ],
                    onChange: (value) => ref
                        .read(sortByTimeProvider.notifier)
                        .update((state) => value == 0),
                  ),
                  const SizedBox(height: 8),

                  /// Usage info cards
                  usageType == UsageType.screenUsage
                      ? UsageInfoCard(
                          label: "Screen time",
                          icon: FluentIcons.phone_20_regular,
                          info: aggregatedUsage
                              .screenTimeThisWeek[dayOfWeek].seconds
                              .toTimeFull(),
                        )
                      : NetworkUsageInfoCard(
                          mobile:
                              aggregatedUsage.mobileUsageThisWeek[dayOfWeek],
                          wifi: aggregatedUsage.wifiUsageThisWeek[dayOfWeek],
                        ),
                ],
              ),
            ),
          ),

          20.vSliverBox(),

          /// Usage bar chart and selected day changer
          Column(
            children: [
              /// Usage bar chart
              BaseBarChart(
                height: 256,
                usageType: usageType,
                selectedBar: dayOfWeek,
                intervalBuilder: (max) => max * 0.275,
                onBarTap: (barIndex) => ref
                    .read(_selectedDayOfWeekProvider.notifier)
                    .update((state) => barIndex),
                data: usageType == UsageType.screenUsage
                    ? aggregatedUsage.screenTimeThisWeek
                    : aggregatedUsage.networkUsageThisWeek,
              ),

              12.vBox(),

              /// Selected day changer
              Container(
                height: 48,
                color: Theme.of(context).cardColor.withOpacity(.3),
              ),
            ],
          ).toSliverBox(),

          /// Most used apps text
          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeader(
              minHeight: 32,
              maxHeight: 56,
              alignment: Alignment.centerLeft,
              child: Text(
                "Most used apps",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),

          /// Apps list
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 48),
            sliver: AnimatedAppsList(
              usageType: usageType,
            ),
          ),
        ],
      ),
    );
  }
}
