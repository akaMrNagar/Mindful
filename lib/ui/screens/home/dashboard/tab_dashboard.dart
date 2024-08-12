import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/aggregated_usage_provider.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/home/dashboard/usage_glance_card.dart';

class TabDashboard extends ConsumerStatefulWidget {
  const TabDashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabDashboardState();
}

class _TabDashboardState extends ConsumerState<TabDashboard> {
  @override
  Widget build(BuildContext context) {
    /// Aggregated usage for whole week on the basis of full day
    final aggregatedUsage = ref.watch(aggregatedUsageProvider);

    return DefaultRefreshIndicator(
      onRefresh: ref.read(appsProvider.notifier).refreshDeviceApps,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// Appbar
            const SliverFlexibleAppBar(title: "Dashboard"),

            const StyledText("Welcome back,").sliver,
            const StyledText(
              "Punish3r",
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ).sliver,
            24.vSliverBox,

            // const SliverContentTitle(title: "Today's overview"),
            // 8.vSliverBox,

            Row(
              children: [
                /// Screen time
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    title: "Screen time",
                    icon: FluentIcons.phone_screen_time_20_regular,
                    progressPercentage: aggregatedUsage
                        .screenTimeThisWeek[todayOfWeek]
                        .toProgress(todayOfWeek >= 1
                            ? aggregatedUsage
                                .screenTimeThisWeek[todayOfWeek - 1]
                            : 0),
                    info: aggregatedUsage
                        .screenTimeThisWeek[todayOfWeek].seconds
                        .toTimeShort(),
                  ),
                ),
                8.hBox,
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    icon: FluentIcons.person_clock_20_regular,
                    title: "Focused time",
                    info: 125.minutes.toTimeShort(),
                    progressPercentage: -36,
                    invertProgress: true,
                  ),
                ),
              ],
            ).sliver,

            // /// Data usage mobile + wifi
            // Row(
            //   children: [
            //     Expanded(
            //       child: UsageGlanceCard(
            //         title: "Mobile data",
            //         icon: FluentIcons.cellular_data_1_20_regular,
            //         progressPercentage: aggregatedUsage
            //             .mobileUsageThisWeek[todayOfWeek]
            //             .toProgress(todayOfWeek >= 1
            //                 ? aggregatedUsage
            //                     .mobileUsageThisWeek[todayOfWeek - 1]
            //                 : 0),
            //         info: aggregatedUsage.mobileUsageThisWeek[todayOfWeek]
            //             .toData(),
            //       ),
            //     ),
            //     8.hBox,
            //     Expanded(
            //       child: UsageGlanceCard(
            //         title: "Wifi data",
            //         icon: FluentIcons.wifi_1_20_regular,
            //         progressPercentage: aggregatedUsage
            //             .wifiUsageThisWeek[todayOfWeek]
            //             .toProgress(todayOfWeek >= 1
            //                 ? aggregatedUsage.wifiUsageThisWeek[todayOfWeek - 1]
            //                 : 0),
            //         info:
            //             aggregatedUsage.wifiUsageThisWeek[todayOfWeek].toData(),
            //       ),
            //     ),
            //   ],
            // ).sliver,

            // 12.vSliverBox,
            // const SliverContentTitle(title: "Your achievements"),
            // 8.vSliverBox,

            UsageGlanceCard(
              icon: FluentIcons.sound_source_20_regular,
              title: "Lifetime focused time",
              info: 125.minutes.toTimeFull(),
              invertProgress: true,
            ).sliver,

            ///
            Row(
              children: [
                const Expanded(
                  child: UsageGlanceCard(
                    title: "Longest streak",
                    icon: FluentIcons.trophy_20_regular,
                    info: "15 days",
                  ),
                ),
                8.hBox,
                const Expanded(
                  child: UsageGlanceCard(
                    title: "Current streak",
                    icon: FluentIcons.fire_20_regular,
                    info: "5 days",
                  ),
                ),
              ],
            ).sliver,

            // 8.vSliverBox,
            // const SliverContentTitle(title: "Quick actions"),
            // 8.vSliverBox,
            DefaultListTile(
              color: Theme.of(context).colorScheme.surfaceContainer,
              leadingIcon: FluentIcons.history_20_regular,
              titleText: "Focus history",
              subtitleText: "See what you did throughout the year",
              trailing: const Icon(FluentIcons.chevron_right_20_regular),
              onPressed: () {},
            ).sliver,
            8.vSliverBox,
            DefaultListTile(
              isPrimary: true,
              titleText: "Focus now",
              leadingIcon: FluentIcons.target_arrow_20_regular,
              subtitleText: "Let's do something productive",
              trailing: const Icon(FluentIcons.chevron_right_20_regular),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.focusScreen);
              },
            ).sliver,

            8.vSliverBox,
            const SliverContentTitle(title: "Suggestions"),
            8.vSliverBox,

            const DefaultListTile(
              leadingIcon: FluentIcons.thumb_like_20_regular,
              subtitleText:
                  "Keep up the work, You are jus 10 days away from beating your longest streak record.",
            ).sliver,
            const DefaultListTile(
              leadingIcon: FluentIcons.thumb_like_20_regular,
              subtitleText:
                  "You have increased your lifetime focused time by 2 hours and 5 minutes today.",
            ).sliver,
            const DefaultListTile(
              leadingIcon: FluentIcons.thumb_like_20_regular,
              subtitleText:
                  "You are doing great! You have reduced your screen time as compared to",
            ).sliver,

            const SliverTabsBottomPadding(),
          ],
        ),
      ),
    );
  }
}
