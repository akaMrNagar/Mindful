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
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/default_models.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/providers/invincible_mode_provider.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/ui/common/active_period_tile_content.dart';
import 'package:mindful/ui/common/default_dropdown_tile.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/app_launch_limit_dialog.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/screens/app_dashboard/app_internet_switcher.dart';
import 'package:mindful/ui/screens/app_dashboard/app_timer.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// Displays available restriction actions for the app in [AppDashboard]

class AppDashboardRestrictions extends ConsumerWidget {
  const AppDashboardRestrictions({
    super.key,
    required this.app,
  });

  final AndroidApp app;

  void _onLaunchCountPressed({
    required BuildContext context,
    required WidgetRef ref,
    required int launchCount,
    required int launchLimit,
  }) async {
    final isAppLimitRestricted = ref.read(invincibleModeProvider
        .select((v) => v.isInvincibleModeOn && v.includeAppsLaunchLimit));

    /// Show snack bar and return if restricted
    if (isAppLimitRestricted && launchLimit > 0 && launchCount > launchLimit) {
      context.showSnackAlert(context.locale.invincible_mode_snack_alert);
      return;
    }

    final newLimit = await showAppLaunchLimitDialog(
      context: context,
      heroTag: HeroTags.appLaunchLimitTileTag(app.packageName),
      initialCount: launchLimit,
    );

    ref.read(appsRestrictionsProvider.notifier).updateAppLaunchLimit(
          app.packageName,
          newLimit ?? launchLimit,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restriction = ref.watch(
          appsRestrictionsProvider.select(
            (v) => v[app.packageName],
          ),
        ) ??
        defaultAppRestrictionModel;

    final restrictionGroupName = ref.watch(restrictionGroupsProvider
        .select((v) => v[restriction.associatedGroupId]?.groupName));

    final canModifyActivePeriod = !(restriction.periodDurationInMins > 0 &&
        ref.watch(invincibleModeProvider.select(
            (v) => v.isInvincibleModeOn && v.includeAppsActivePeriod)) &&
        !DateTime.now().isBetweenTod(
          restriction.activePeriodStart,
          restriction.activePeriodEnd,
        ));

    return MultiSliver(
      children: [
        ContentSectionHeader(title: context.locale.restrictions_heading).sliver,

        /// App Timer tile
        AppTimer(app: app).sliver,

        /// App launch limit
        DefaultHero(
          tag: HeroTags.appLaunchLimitTileTag(app.packageName),
          child: DefaultListTile(
            enabled: !app.isImpSysApp,
            position: ItemPosition.mid,
            titleText: context.locale.app_launch_limit_tile_title,
            subtitleText:
                context.locale.app_launch_limit_tile_subtitle(app.launchCount),
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
              launchCount: app.launchCount,
              launchLimit: restriction.launchLimit,
            ),
          ),
        ).sliver,

        /// Active period
        DefaultExpandableListTile(
          enabled: !app.isImpSysApp,
          position: ItemPosition.mid,
          contentPosition: ItemPosition.mid,
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
                      app.packageName,
                      start,
                      end,
                    ),
          ),
        ).sliver,

        /// Internet access
        AppInternetSwitcher(app: app).sliver,

        /// Associated restriction group
        DefaultListTile(
          enabled: !app.isImpSysApp,
          position: ItemPosition.end,
          titleText: context.locale.restriction_groups_tab_title,
          subtitleText:
              restrictionGroupName ?? context.locale.app_limit_status_not_set,
          leadingIcon: FluentIcons.app_title_20_regular,
          trailing: Icon(
            FluentIcons.chevron_right_20_regular,
            color: app.isImpSysApp ? Theme.of(context).disabledColor : null,
          ),
          onPressed: () => Navigator.of(context)
              .pushNamed(AppRoutes.restrictionGroupsScreen),
        ).sliver,

        /// Alerts section
        ContentSectionHeader(title: context.locale.usage_alerts_heading).sliver,

        /// Alert interval
        DefaultHero(
          tag: HeroTags.appAlertIntervalTileTag(app.packageName),
          child: DefaultListTile(
            enabled: !app.isImpSysApp,
            position: ItemPosition.start,
            titleText: context.locale.app_alert_interval_tile_title,
            subtitleText: context.locale.app_alert_interval_tile_subtitle(
              restriction.alertInterval.seconds.toTimeFull(context),
            ),
            leadingIcon: FluentIcons.alert_urgent_20_regular,
            onPressed: () async => showAppAlertIntervalPicker(
              context: context,
              heroTag: HeroTags.appAlertIntervalTileTag(app.packageName),
              initialTime: restriction.alertInterval,
            ).then(
              (v) => ref
                  .read(appsRestrictionsProvider.notifier)
                  .updateAlertInterval(
                    app.packageName,
                    v ?? restriction.alertInterval,
                  ),
            ),
          ),
        ).sliver,

        /// Alert type
        DefaultDropdownTile<bool>(
          enabled: !app.isImpSysApp,
          position: ItemPosition.end,
          value: restriction.alertByDialog,
          leadingIcon: FluentIcons.channel_alert_20_regular,
          dialogIcon: FluentIcons.channel_alert_20_filled,
          titleText: context.locale.app_alert_type_tile_title,
          onSelected: (v) => ref
              .read(appsRestrictionsProvider.notifier)
              .setAlertByDialog(app.packageName, v),
          items: [
            DefaultDropdownItem(
              label: context.locale.app_alert_type_notification,
              value: false,
            ),
            DefaultDropdownItem(
              label: context.locale.app_alert_type_dialog,
              value: true,
            ),
          ],
        ).sliver,
      ],
    );
  }
}
