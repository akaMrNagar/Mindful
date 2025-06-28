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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/default_models_utils.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/providers/restrictions/web_restrictions_provider.dart';
import 'package:mindful/providers/system/parental_controls_provider.dart';
import 'package:mindful/providers/usage/launch_count_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/app_launch_limit_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:mindful/ui/screens/websites_blocking/web_timer_tile.dart';

/// Displays available restriction actions for the host in [WebDashboard]
class WebDashboardRestrictions extends ConsumerWidget {
  const WebDashboardRestrictions({
    super.key,
    required this.host,
    required this.webTimeSpent,
  });

  final String host;
  final int webTimeSpent;

  void _onLaunchCountPressed({
    required BuildContext context,
    required WidgetRef ref,
    required int launchLimit,
  }) async {
    /// If restricted by invincible mode
    final isInvincibleRestricted = ref.read(parentalControlsProvider
            .select((v) => v.isInvincibleModeOn && v.includeAppsLaunchLimit)) &&
        !ref.read(parentalControlsProvider.notifier).isBetweenInvincibleWindow;

    /// Show snack bar and return if restricted
    if (isInvincibleRestricted && launchLimit > 0) {
      context.showSnackAlert(context.locale.invincible_mode_snack_alert);
      return;
    }

    final newLimit = await showAppLaunchLimitDialog(
      context: context,
      heroTag: HeroTags.appLaunchLimitTileTag(host),
      initialCount: launchLimit,
    );

    ref.read(webRestrictionsProvider.notifier).updateWebLaunchLimit(
      host,
      newLimit ?? launchLimit
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todaysLaunchCount = ref.watch(webLaunchCountProvider
        .select((v) => v.value?[host] ?? 0));
    final restriction = ref.watch(
          webRestrictionsProvider.select(
            (v) => v[host],
          ),
        ) ??
        defaultWebRestrictionModel;

    final webTimer = ref.watch(webRestrictionsProvider
            .select((value) => value[host]?.timerSec)) ??
        0;

    return MultiSliver(
      children: [
        ContentSectionHeader(title: context.locale.restrictions_heading).sliver,

        /// Web Timer tile
        WebTimerTile(
          host: host,
          webTimer: webTimer,
          webTimeSpent: webTimeSpent,
        ).sliver,

        /// Web launch limit
        DefaultHero(
          tag: HeroTags.webLaunchLimitTileTag(host),
          child: DefaultListTile(
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
              launchLimit: restriction.launchLimit,
            ),
          ),
        ).sliver,
      ],
    );
  }
}
