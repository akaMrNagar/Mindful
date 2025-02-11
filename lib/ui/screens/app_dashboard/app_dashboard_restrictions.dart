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
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/default_models_utils.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/models/app_info.dart';
import 'package:mindful/providers/restrictions/apps_restrictions_provider.dart';
import 'package:mindful/providers/system/parental_controls_provider.dart';
import 'package:mindful/providers/usage/apps_launch_count_provider.dart';
import 'package:mindful/providers/restrictions/restriction_groups_provider.dart';
import 'package:mindful/ui/common/active_period_tile_content.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/app_launch_limit_dialog.dart';
import 'package:mindful/ui/screens/app_dashboard/app_internet_tile.dart';
import 'package:mindful/ui/screens/app_dashboard/app_timer_tile.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// Displays available restriction actions for the app in [AppDashboard]
class AppDashboardRestrictions extends ConsumerWidget {
  const AppDashboardRestrictions({
    super.key,
    required this.appInfo,
    required this.appTimer,
    required this.isPurged,
  });

  final AppInfo appInfo;
  final int appTimer;
  final bool isPurged;

  void _onLaunchCountPressed({
    required BuildContext context,
    required WidgetRef ref,
    required int launchCount,
    required int launchLimit,
  }) async {
    final isAppLimitRestricted = ref.read(parentalControlsProvider
        .select((v) => v.isInvincibleModeOn && v.includeAppsLaunchLimit));

    /// Show snack bar and return if restricted
    if (isAppLimitRestricted && launchLimit > 0 && launchCount > launchLimit) {
      context.showSnackAlert(context.locale.invincible_mode_snack_alert);
      return;
    }

    final newLimit = await showAppLaunchLimitDialog(
      context: context,
      heroTag: HeroTags.appLaunchLimitTileTag(appInfo.packageName),
      initialCount: launchLimit,
    );

    ref.read(appsRestrictionsProvider.notifier).updateAppLaunchLimit(
          appInfo.packageName,
          newLimit ?? launchLimit,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todaysLaunchCount = ref.watch(appsLaunchCountProvider
        .select((v) => v.value?[appInfo.packageName] ?? 0));

    final restriction = ref.watch(
          appsRestrictionsProvider.select(
            (v) => v[appInfo.packageName],
          ),
        ) ??
        defaultAppRestrictionModel;

    final restrictionGroupName = ref.watch(restrictionGroupsProvider
        .select((v) => v[restriction.associatedGroupId]?.groupName));

    final canModifyActivePeriod = !(restriction.periodDurationInMins > 0 &&
        ref.watch(parentalControlsProvider.select(
            (v) => v.isInvincibleModeOn && v.includeAppsActivePeriod)) &&
        !DateTime.now().isBetweenTod(
          restriction.activePeriodStart,
          restriction.activePeriodEnd,
        ));

    return MultiSliver(
      children: [
        ContentSectionHeader(title: context.locale.restrictions_heading).sliver,

        /// App Timer tile
        AppTimerTile(
          appInfo: appInfo,
          appTimer: appTimer,
          isPurged: isPurged,
        ).sliver,

        /// App launch limit
        DefaultHero(
          tag: HeroTags.appLaunchLimitTileTag(appInfo.packageName),
          child: DefaultListTile(
            enabled: !appInfo.isImpSysApp,
            position: ItemPosition.mid,
            titleText: context.locale.app_launch_limit_tile_title,
            subtitleText: context.locale
                .app_launch_limit_tile_subtitle(todaysLaunchCount),
            leadingIcon: FluentIcons.rocket_20_regular,
            trailing: restriction.launchLimit > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: StyledText(
                      restriction.launchLimit.toString(),
                      fontSize: 16,
                    ),
                  )
                : StyledText(
                    context.locale.app_limit_status_not_set,
                    isSubtitle: true,
                  ),
            onPressed: () => _onLaunchCountPressed(
              context: context,
              ref: ref,
              launchCount: todaysLaunchCount,
              launchLimit: restriction.launchLimit,
            ),
          ),
        ).sliver,

        /// Active period
        DefaultExpandableListTile(
          enabled: !appInfo.isImpSysApp,
          position: ItemPosition.mid,
          leadingIcon: FluentIcons.drink_coffee_20_regular,
          titleText: context.locale.app_active_period_tile_title,
          subtitleText: restriction.periodDurationInMins > 0
              ? context.locale.app_active_period_tile_subtitle(
                  restriction.activePeriodStart.format(context),
                  restriction.activePeriodEnd.format(context),
                )
              : context.locale.app_limit_status_not_set,
          content: ActivePeriodTileContent(
            totalDuration: restriction.periodDurationInMins.minutes,
            startTime: restriction.activePeriodStart,
            endTime: restriction.activePeriodEnd,
            isModifiable: () {
              if (!canModifyActivePeriod) {
                context
                    .showSnackAlert(context.locale.invincible_mode_snack_alert);
              }

              return canModifyActivePeriod;
            },
            onTimeChanged: (start, end) =>
                ref.read(appsRestrictionsProvider.notifier).updateActivePeriod(
                      appInfo.packageName,
                      start,
                      end,
                    ),
          ),
        ).sliver,

        /// Internet access
        AppInternetTile(appInfo: appInfo).sliver,

        /// Associated restriction group
        DefaultListTile(
          enabled: !appInfo.isImpSysApp,
          position: ItemPosition.bottom,
          titleText: context.locale.restriction_groups_tab_title,
          subtitleText:
              restrictionGroupName ?? context.locale.app_limit_status_not_set,
          leadingIcon: FluentIcons.app_title_20_regular,
          trailing: Icon(
            FluentIcons.chevron_right_20_regular,
            color: appInfo.isImpSysApp ? Theme.of(context).disabledColor : null,
          ),
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoutes.restrictionGroupsPath),
        ).sliver,
      ],
    );
  }
}
