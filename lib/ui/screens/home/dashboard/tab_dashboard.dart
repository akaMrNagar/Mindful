import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/active_session_provider.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/focus_stats_provider.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/sliver_active_session_alert.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TabDashboard extends ConsumerStatefulWidget {
  const TabDashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabDashboardState();
}

class _TabDashboardState extends ConsumerState<TabDashboard> {
  @override
  void initState() {
    super.initState();
    ref.read(activeSessionProvider.notifier).refreshActiveSessionState();
  }

  void _editUserName() async {
    final userName = await showUsernameInputDialog(
      context: context,
      heroTag: HeroTags.editUsernameTag,
    );

    if (userName == null) return;
    ref.read(settingsProvider.notifier).changeUsername(userName);
  }

  @override
  Widget build(BuildContext context) {
    final currentStreak =
        ref.watch(focusModeProvider.select((v) => v.currentStreak));

    final longestStreak =
        ref.watch(focusModeProvider.select((v) => v.longestStreak));

    final focusStats = ref.watch(focusStatsProvider);

    final username = ref.watch(settingsProvider.select((v) => v.username));

    return DefaultRefreshIndicator(
      onRefresh: ref.read(focusStatsProvider.notifier).refreshFocusStats,
      child: Skeletonizer.zone(
        enabled: focusStats.isLoading || ref.read(appsProvider).isLoading,
        ignorePointers: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// Appbar
            const SliverFlexibleAppBar(title: "Dashboard"),

            const StyledText("Welcome back,").sliver,

            /// User name
            DefaultHero(
              tag: HeroTags.editUsernameTag,
              child: Row(
                children: [
                  InkWell(
                    onLongPress: _editUserName,
                    onTap: () => context.showSnackAlert(
                      "Long press to edit username.",
                      icon: FluentIcons.edit_20_filled,
                    ),
                    splashColor:
                        Theme.of(context).colorScheme.surfaceContainerLow,
                    child: StyledText(
                      username,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).sliver,

            24.vSliverBox,

            Row(
              children: [
                /// Screen time
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    title: "Screen time",
                    icon: FluentIcons.phone_screen_time_20_regular,
                    progressPercentage: focusStats
                            .value?.todaysScreenTime.inSeconds
                            .toDiffPercentage(focusStats
                                    .value?.yesterdaysScreenTime.inSeconds ??
                                1) ??
                        0,
                    info: focusStats.value?.todaysScreenTime.toTimeShort() ??
                        "0h 0m",
                  ),
                ),
                8.hBox,

                // Focused time
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    invertProgress: true,
                    icon: FluentIcons.person_clock_20_regular,
                    title: "Focused time",
                    info: focusStats.value?.todaysFocusedTime.toTimeShort() ??
                        "0h 0m",
                    progressPercentage: focusStats
                            .value?.todaysFocusedTime.inMinutes
                            .toDiffPercentage(focusStats
                                    .value?.yesterdaysFocusedTime.inMinutes ??
                                1) ??
                        0,
                  ),
                ),
              ],
            ).sliver,

            /// Active session
            const SliverActiveSessionAlert(),

            /// Total focused time from install to till now
            UsageGlanceCard(
              icon: FluentIcons.sound_source_20_regular,
              title: "Lifetime focused time",
              info: focusStats.value?.lifetimeFocusedTime.toTimeFull() ??
                  "0 hours, 0 minutes",
              invertProgress: true,
            ).sliver,

            /// Streaks
            Row(
              children: [
                Expanded(
                  child: UsageGlanceCard(
                    title: "Longest streak",
                    icon: FluentIcons.trophy_20_regular,
                    info: "$longestStreak days",
                  ),
                ),
                8.hBox,
                Expanded(
                  child: UsageGlanceCard(
                    title: "Current streak",
                    icon: FluentIcons.fire_20_regular,
                    info: "$currentStreak days",
                  ),
                ),
              ],
            ).sliver,

            /// Sessions
            Row(
              children: [
                Expanded(
                  child: UsageGlanceCard(
                    title: "Successful sessions",
                    icon: FluentIcons.thumb_like_20_regular,
                    info:
                        focusStats.value?.successfulSessions.toString() ?? "0",
                  ),
                ),
                8.hBox,
                Expanded(
                  child: UsageGlanceCard(
                    title: "Failed sessions",
                    icon: FluentIcons.thumb_dislike_20_regular,
                    info: focusStats.value?.failedSessions.toString() ?? "0",
                  ),
                ),
              ],
            ).sliver,

            DefaultListTile(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              leadingIcon: FluentIcons.history_20_regular,
              titleText: "Focus timeline",
              subtitleText: "See your achievements since install.",
              trailing: const Icon(FluentIcons.chevron_right_20_regular),
              onPressed: () => Navigator.of(context)
                  .pushNamed(AppRoutes.focusScreen, arguments: 1),
            ).sliver,
            8.vSliverBox,
            DefaultListTile(
              isPrimary: true,
              titleText: "Focus now",
              leadingIcon: FluentIcons.target_arrow_20_regular,
              subtitleText: "Let's do something productive.",
              trailing: const Icon(FluentIcons.chevron_right_20_regular),
              onPressed: () => Navigator.of(context)
                  .pushNamed(AppRoutes.focusScreen, arguments: 0),
            ).sliver,

            const SliverTabsBottomPadding(),
          ],
        ),
      ),
    );
  }
}
