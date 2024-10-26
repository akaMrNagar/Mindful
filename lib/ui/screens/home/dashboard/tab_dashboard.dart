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
import 'package:mindful/ui/common/sliver_active_session_alert.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/transitions/default_effects.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TabDashboard extends ConsumerWidget {
  const TabDashboard({super.key});

  void _editUserName(BuildContext context, WidgetRef ref) async {
    final userName = await showUsernameInputDialog(
      context: context,
      heroTag: HeroTags.editUsernameTag,
    );

    if (userName == null) return;
    ref.read(mindfulSettingsProvider.notifier).changeUsername(userName);
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
        title: context.locale.invincible_mode_heading,
        info: context.locale.invincible_mode_dialog_info,
        positiveLabel:
            context.locale.invincible_mode_dialog_button_start_anyway,
      );
      if (isConfirm) {
        ref.read(mindfulSettingsProvider.notifier).switchInvincibleMode();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStreak =
        ref.watch(focusModeProvider.select((v) => v.currentStreak));

    final longestStreak =
        ref.watch(focusModeProvider.select((v) => v.longestStreak));

    final isInvincibleModeOn =
        ref.watch(mindfulSettingsProvider.select((v) => v.isInvincibleModeOn));

    final focusStats = ref.watch(focusStatsProvider);

    final username =
        ref.watch(mindfulSettingsProvider.select((v) => v.username));

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
                onLongPress: () => _editUserName(context, ref),
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
            const SliverActiveSessionAlert(margin: EdgeInsets.only(bottom: 8)),

            SliverList.list(
              children: [
                Row(
                  children: [
                    /// Screen time
                    Expanded(
                      child: UsageGlanceCard(
                        isPrimary: true,
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
                    8.hBox,

                    // Focused time
                    Expanded(
                      child: UsageGlanceCard(
                        isPrimary: true,
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
                    8.hBox,
                    Expanded(
                      child: UsageGlanceCard(
                        title: context.locale.current_streak_label,
                        icon: FluentIcons.fire_20_regular,
                        info: context.locale.nDays(currentStreak),
                      ),
                    ),
                  ],
                ),

                /// Sessions
                Row(
                  children: [
                    Expanded(
                      child: UsageGlanceCard(
                        title: context.locale.successful_sessions_label,
                        icon: FluentIcons.thumb_like_20_regular,
                        info: focusStats.successfulSessions.toString(),
                      ),
                    ),
                    8.hBox,
                    Expanded(
                      child: UsageGlanceCard(
                        title: context.locale.failed_sessions_label,
                        icon: FluentIcons.thumb_dislike_20_regular,
                        info: focusStats.failedSessions.toString(),
                      ),
                    ),
                  ],
                ),
              ].animateListWhen(
                when: !ref.read(appsProvider).hasValue,
                effects: DefaultEffects.transitionIn,
                interval: 100.ms,
              ),
            ),

            20.vSliverBox,

            /// Invincible mode
            SliverContentTitle(title: context.locale.invincible_mode_heading),

            /// Information about invincible mode
            StyledText(
              context.locale.invincible_mode_info,
            ).sliver,
            12.vSliverBox,

            /// Invincible mode
            DefaultHero(
              tag: HeroTags.invincibleModeTileTag,
              child: DefaultListTile(
                isPrimary: true,
                switchValue: isInvincibleModeOn,
                enabled: !isInvincibleModeOn,
                leadingIcon: FluentIcons.bow_tie_20_regular,
                titleText: context.locale.invincible_mode_tile_title,
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
}
