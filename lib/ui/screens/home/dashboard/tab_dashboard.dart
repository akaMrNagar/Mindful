/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_list.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/focus_stats_provider.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/sliver_active_session_alert.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/permissions/alarm_permission.dart';
import 'package:mindful/ui/permissions/display_overlay_permission.dart';
import 'package:mindful/ui/permissions/notification_permission.dart';
import 'package:mindful/ui/permissions/usage_access_permission.dart';
import 'package:mindful/ui/transitions/default_effects.dart';
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
    ref.read(focusModeProvider.notifier).refreshActiveSessionState();
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

    final isInvincibleModeOn =
        ref.watch(settingsProvider.select((v) => v.isInvincibleModeOn));

    final focusStats = ref.watch(focusStatsProvider);

    final username = ref.watch(settingsProvider.select((v) => v.username));

    return Skeletonizer.zone(
      enabled: ref.read(appsProvider).isLoading,
      enableSwitchAnimation: true,
      ignorePointers: false,
      child: DefaultRefreshIndicator(
        onRefresh: ref.read(appsProvider.notifier).refreshDeviceApps,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// Appbar
            const SliverFlexibleAppBar(title: "Dashboard"),

            const StyledText("Welcome back,").sliver,

            /// User name
            DefaultHero(
              tag: HeroTags.editUsernameTag,
              child: InkWell(
                onLongPress: _editUserName,
                onTap: () => context.showSnackAlert(
                  "Long press to edit username.",
                  icon: FluentIcons.edit_20_filled,
                ),
                splashColor: Theme.of(context).colorScheme.surfaceContainerLow,
                child: StyledText(
                  username,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).sliver,

            24.vSliverBox,

            const NotificationPermission(),

            const ExactAlarmPermission(),

            const UsageAccessPermission(),

            const DisplayOverlayPermission(),

            SliverList.list(
              children: [
                Row(
                  children: [
                    /// Screen time
                    Expanded(
                      child: UsageGlanceCard(
                        isPrimary: true,
                        title: "Screen time",
                        icon: FluentIcons.phone_screen_time_20_regular,
                        progressPercentage: focusStats
                            .todaysScreenTime.inSeconds
                            .toDiffPercentage(
                          focusStats.yesterdaysScreenTime.inSeconds,
                        ),
                        info: focusStats.todaysScreenTime.toTimeShort(),
                        onTap: () => context.showSnackAlert(
                          "Your total screen time for today is ${focusStats.todaysScreenTime.toTimeFull()}.",
                          icon: FluentIcons.phone_screen_time_20_filled,
                        ),
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
                        info: focusStats.todaysFocusedTime.toTimeShort(),
                        progressPercentage: focusStats
                            .todaysFocusedTime.inMinutes
                            .toDiffPercentage(
                          focusStats.yesterdaysFocusedTime.inMinutes,
                        ),
                        onTap: () => context.showSnackAlert(
                          "Your total focused time for today is ${focusStats.todaysFocusedTime.toTimeFull()}.",
                          icon: FluentIcons.person_clock_20_filled,
                        ),
                      ),
                    ),
                  ],
                ),

                /// Total focused time from install to till now
                UsageGlanceCard(
                  icon: FluentIcons.sound_source_20_regular,
                  title: "Lifetime focused time",
                  info: focusStats.lifetimeFocusedTime.toTimeFull(),
                  invertProgress: true,
                  onTap: () => context.showSnackAlert(
                    "Your total focused time since install is ${focusStats.lifetimeFocusedTime.toTimeFull()}.",
                    icon: FluentIcons.sound_source_20_filled,
                  ),
                ),

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
                ),

                /// Sessions
                Row(
                  children: [
                    Expanded(
                      child: UsageGlanceCard(
                        title: "Successful sessions",
                        icon: FluentIcons.thumb_like_20_regular,
                        info: focusStats.successfulSessions.toString(),
                      ),
                    ),
                    8.hBox,
                    Expanded(
                      child: UsageGlanceCard(
                        title: "Failed sessions",
                        icon: FluentIcons.thumb_dislike_20_regular,
                        info: focusStats.failedSessions.toString(),
                      ),
                    ),
                  ],
                ),

                DefaultListTile(
                  isPrimary: true,
                  titleText: "Focus now",
                  leadingIcon: FluentIcons.target_arrow_20_regular,
                  subtitleText: "Let's do something productive.",
                  trailing: const Icon(FluentIcons.chevron_right_20_regular),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.focusScreen, arguments: 0),
                ),
                8.vBox,

                DefaultListTile(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  leadingIcon: FluentIcons.history_20_regular,
                  titleText: "Focus timeline",
                  subtitleText: "See your achievements since install.",
                  trailing: const Icon(FluentIcons.chevron_right_20_regular),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.focusScreen, arguments: 1),
                ),
              ].animateListWhen(
                when: !ref.read(appsProvider).hasValue,
                effects: DefaultEffects.transitionIn,
                interval: 100.ms,
              ),
            ),

            /// Active session
            const SliverActiveSessionAlert(margin: EdgeInsets.only(top: 8)),

            20.vSliverBox,

            /// Invincible mode
            const SliverContentTitle(title: "Invincible mode"),

            /// Information about invincible mode
            const StyledText(
                    "When Invincible Mode is active, modifying the app's timer after it runs out or adjusting the short content settings after reaching the daily limit is not permitted.")
                .sliver,
            12.vSliverBox,

            /// Invincible mode
            DefaultHero(
              tag: HeroTags.invincibleModeTileTag,
              child: DefaultListTile(
                isPrimary: true,
                switchValue: isInvincibleModeOn,
                enabled: !isInvincibleModeOn,
                leadingIcon: FluentIcons.animal_cat_20_regular,
                titleText: "Activate invincible mode",
                onPressed: () =>
                    _turnOnInvincibleMode(context, ref, !isInvincibleModeOn),
              ),
            ).sliver,

            const SliverTabsBottomPadding(),
          ],
        ),
      ),
    );
  }

  void _turnOnInvincibleMode(
    BuildContext context,
    WidgetRef ref,
    bool shouldTurnOn,
  ) async {
    if (shouldTurnOn) {
      final isConfirm = await showConfirmationDialog(
        context: context,
        icon: FluentIcons.animal_cat_20_filled,
        heroTag: HeroTags.invincibleModeTileTag,
        title: "Invincible mode",
        info:
            "Are you absolutely sure you want to enable Invincible Mode? This action is irreversible. Once Invincible Mode is turned on, you cannot turn it off as long as this app is installed on your device.",
        positiveLabel: "Start anyway",
      );
      if (isConfirm) {
        ref.read(settingsProvider.notifier).switchInvincibleMode();
      }
    }
  }
}
