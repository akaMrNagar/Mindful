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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/database/tables/app_restriction_table.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/app_launch_limit_dialog.dart';
import 'package:mindful/ui/dialogs/app_session_limit_dialog.dart';
import 'package:mindful/ui/screens/app_dashboard/app_internet_switcher.dart';
import 'package:mindful/ui/screens/app_dashboard/app_timer_picker.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// Displays available restriction actions for the app in [AppDashboard]

class AppDashboardRestrictions extends ConsumerWidget {
  const AppDashboardRestrictions({
    super.key,
    required this.app,
  });

  final AndroidApp app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restriction = ref.watch(
          appsRestrictionsProvider.select(
            (v) => v[app.packageName],
          ),
        ) ??
        AppRestrictionTable.defaultAppRestrictionModel;

    final restrictionGroup = ref.read(restrictionGroupsProvider
        .select((v) => v[restriction.associatedGroupId]));

    return MultiSliver(
      children: [
        const ContentSectionHeader(title: "Restrictions").sliver,

        /// App Timer tile
        AppTimerPicker(app: app).sliver,

        /// App launch limit
        DefaultHero(
          tag: HeroTags.appLaunchLimitTileTag(app.packageName),
          child: DefaultListTile(
            position: ItemPosition.mid,
            titleText: "App launch limit",
            subtitleText: "Launched 15 times today.",
            leadingIcon: FluentIcons.rocket_20_regular,
            trailing: restriction.launchLimit > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: StyledText(restriction.launchLimit.toString(),
                        fontSize: 16),
                  )
                : const StyledText("Not set", isSubtitle: true),
            onPressed: () async => showAppLaunchLimitDialog(
              context: context,
              heroTag: HeroTags.appLaunchLimitTileTag(app.packageName),
              initialCount: 50,
            ),
          ),
        ).sliver,

        /// Session and Cooldown limit
        DefaultHero(
          tag: HeroTags.appSessionAndCooldownTileTag(app.packageName),
          child: DefaultListTile(
            position: ItemPosition.mid,
            titleText: "Session & Cooldown limit",
            subtitleText: "Use for 1h 30m and wait for 2h 45m.",
            leadingIcon: FluentIcons.shifts_availability_20_regular,
            onPressed: () async => showAppSessionLimitDialog(
              context: context,
              heroTag: HeroTags.appSessionAndCooldownTileTag(app.packageName),
              initialCount: 500,
            ),
          ),
        ).sliver,

        /// Associated restriction group
        DefaultListTile(
          position: ItemPosition.mid,
          titleText: "Restriction group",
          subtitleText:
              restrictionGroup == null ? "Not set" : restrictionGroup.groupName,
          leadingIcon: FluentIcons.app_title_20_regular,
          trailing: const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: () => Navigator.of(context)
              .pushNamed(AppRoutes.restrictionGroupsScreen),
        ).sliver,

        /// Internet access
        AppInternetSwitcher(app: app).sliver,
      ],
    );
  }
}
