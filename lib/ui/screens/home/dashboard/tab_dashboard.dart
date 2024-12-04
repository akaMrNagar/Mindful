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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/enums/item_position.dart';
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
import 'package:mindful/providers/mindful_settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_active_session_alert.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/screens/home/dashboard/invincible_mode_settings.dart';
import 'package:mindful/ui/transitions/default_effects.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TabDashboard extends ConsumerWidget {
  const TabDashboard({super.key});

  void _editUserName(
      BuildContext context, WidgetRef ref, String initialName) async {
    final userName = await showUsernameInputDialog(
      context: context,
      heroTag: HeroTags.editUsernameTag,
      initialText: initialName,
    );

    if (userName == null) return;
    ref.read(mindfulSettingsProvider.notifier).changeUsername(userName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStreak =
        ref.watch(focusModeProvider.select((v) => v.focusMode.currentStreak));

    final longestStreak =
        ref.watch(focusModeProvider.select((v) => v.focusMode.longestStreak));

    final focusStats = ref.watch(focusStatsProvider);

    final username =
        ref.watch(mindfulSettingsProvider.select((v) => v.username));

    const tilesGap = 4;

    return DefaultRefreshIndicator(
      onRefresh: ref.read(appsProvider.notifier).refreshDeviceApps,
      child: Skeletonizer.zone(
        enabled: ref.read(appsProvider).isLoading,
        enableSwitchAnimation: true,
        ignorePointers: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            StyledText(context.locale.welcome_greetings).sliver,

            /// User name
            DefaultHero(
              tag: HeroTags.editUsernameTag,
              child: InkWell(
                onLongPress: () => _editUserName(context, ref, username),
                onTap: () => context.showSnackAlert(
                  context.locale.username_snack_alert,
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

            /// Active session
            const SliverActiveSessionAlert(),

            Column(
              children: [
                Row(
                  children: [
                    /// Screen time
                    Expanded(
                      child: UsageGlanceCard(
                        isPrimary: true,
                        borderRadius: BorderRadius.circular(6)
                            .copyWith(topLeft: const Radius.circular(24)),
                        title: context.locale.screen_time_label,
                        icon: FluentIcons.phone_screen_time_20_regular,
                        progressPercentage: focusStats
                            .todaysScreenTime.inSeconds
                            .toDiffPercentage(
                          focusStats.yesterdaysScreenTime.inSeconds,
                        ),
                        info: focusStats.todaysScreenTime.toTimeShort(context),
                        onTap: () => context.showSnackAlert(
                          context.locale.screen_time_snack_alert(
                            focusStats.todaysScreenTime.toTimeFull(context),
                          ),
                          icon: FluentIcons.phone_screen_time_20_filled,
                        ),
                      ),
                    ),
                    tilesGap.hBox,

                    // Focused time
                    Expanded(
                      child: UsageGlanceCard(
                        isPrimary: true,
                        borderRadius: BorderRadius.circular(6)
                            .copyWith(topRight: const Radius.circular(24)),
                        invertProgress: true,
                        icon: FluentIcons.person_clock_20_regular,
                        title: context.locale.focused_time_label,
                        info: focusStats.todaysFocusedTime.toTimeShort(context),
                        progressPercentage: focusStats
                            .todaysFocusedTime.inMinutes
                            .toDiffPercentage(
                          focusStats.yesterdaysFocusedTime.inMinutes,
                        ),
                        onTap: () => context.showSnackAlert(
                          context.locale.focused_time_snack_alert(
                            focusStats.todaysFocusedTime.toTimeFull(context),
                          ),
                          icon: FluentIcons.person_clock_20_filled,
                        ),
                      ),
                    ),
                  ],
                ),

                tilesGap.vBox,

                /// Total focused time from install to till now
                UsageGlanceCard(
                  icon: FluentIcons.sound_source_20_regular,
                  title: context.locale.lifetime_focused_time_label,
                  info: focusStats.lifetimeFocusedTime.toTimeFull(context),
                  invertProgress: true,
                  onTap: () => context.showSnackAlert(
                    context.locale.lifetime_focused_time_snack_alert(
                      focusStats.lifetimeFocusedTime.toTimeFull(context),
                    ),
                    icon: FluentIcons.sound_source_20_filled,
                  ),
                ),

                tilesGap.vBox,

                /// Streaks
                Row(
                  children: [
                    Expanded(
                      child: UsageGlanceCard(
                        title: context.locale.longest_streak_label,
                        icon: FluentIcons.trophy_20_regular,
                        info: context.locale.nDays(longestStreak),
                      ),
                    ),
                    tilesGap.hBox,
                    Expanded(
                      child: UsageGlanceCard(
                        title: context.locale.current_streak_label,
                        icon: FluentIcons.fire_20_regular,
                        info: context.locale.nDays(currentStreak),
                      ),
                    ),
                  ],
                ),
                tilesGap.vBox,

                /// Sessions
                Row(
                  children: [
                    Expanded(
                      child: UsageGlanceCard(
                        borderRadius: BorderRadius.circular(6),
                        title: context.locale.successful_sessions_label,
                        icon: FluentIcons.thumb_like_20_regular,
                        info: focusStats.successfulSessions.toString(),
                      ),
                    ),
                    tilesGap.hBox,
                    Expanded(
                      child: UsageGlanceCard(
                        borderRadius: BorderRadius.circular(6),
                        title: context.locale.failed_sessions_label,
                        icon: FluentIcons.thumb_dislike_20_regular,
                        info: focusStats.failedSessions.toString(),
                      ),
                    ),
                  ],
                ),
                2.vBox,

                /// Go to focus tab
                DefaultListTile(
                  position: ItemPosition.mid,
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  titleText: context.locale.focus_now_tile_title,
                  leadingIcon: FluentIcons.target_arrow_20_regular,
                  subtitleText: context.locale.focus_now_tile_subtitle,
                  trailing: const Icon(FluentIcons.chevron_right_20_regular),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.focusScreen, arguments: 0),
                ),

                /// Go to focus timeline tab
                DefaultListTile(
                  position: ItemPosition.end,
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  leadingIcon: FluentIcons.history_20_regular,
                  titleText: context.locale.focus_timeline_tile_title,
                  subtitleText: context.locale.focus_timeline_tile_subtitle,
                  trailing: const Icon(FluentIcons.chevron_right_20_regular),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.focusScreen, arguments: 1),
                ),
              ].animateListWhen(
                when: !ref.read(appsProvider).hasValue,
                effects: DefaultEffects.transitionIn,
                interval: 75.ms,
              ),
            ).sliver,

            8.vSliverBox,

            const InvincibleModeSettings(),

            const SliverTabsBottomPadding(),
          ],
        ),
      ),
    );
  }
}
