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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/shared_unique_data_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:mindful/ui/dialogs/modal_bottom_sheet.dart';
import 'package:mindful/ui/permissions/notification_access_permission_card.dart';
import 'package:mindful/ui/screens/batch_notifications/new_notification_schedule_fab.dart';
import 'package:mindful/ui/screens/batch_notifications/sliver_batched_apps_list.dart';
import 'package:mindful/ui/screens/batch_notifications/sliver_schedules_list.dart';

class BatchNotificationsScreen extends ConsumerWidget {
  const BatchNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveNotificationAccessPermission));

    final batchedAppsCount = ref.watch(sharedUniqueDataProvider
        .select((v) => v.notificationBatchedApps.length));

    /// Glance card badge
    final badgeIcon = Icon(
      FluentIcons.arrow_up_right_20_filled,
      color: Theme.of(context).hintColor,
      size: 12,
    );

    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.channel_alert_20_regular,
          filledIcon: FluentIcons.channel_alert_20_filled,
          title: context.locale.batch_notifications_tab_title,
          fab: havePermission ? const NewNotificationScheduleFab() : null,
          sliverBody: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// Information about notification groups
              StyledText(context.locale.batch_notifications_tab_info).sliver,

              16.vSliverBox,

              /// Upcoming notifications and Batched apps
              Row(
                children: [
                  /// Upcoming notifications
                  Expanded(
                    child: UsageGlanceCard(
                      isPrimary: true,
                      badge: badgeIcon,
                      position: havePermission
                          ? ItemPosition.left
                          : ItemPosition.topLeft,
                      icon: FluentIcons.alert_badge_20_regular,
                      title: context.locale.upcoming_notifications_tab_title,
                      info: "35",
                      onTap: () => Navigator.of(context)
                          .pushNamed(AppRoutes.upcomingNotificationsScreen),
                    ),
                  ),
                  4.hBox,

                  /// Batched apps
                  Expanded(
                    child: UsageGlanceCard(
                      isPrimary: true,
                      badge: badgeIcon,
                      position: havePermission
                          ? ItemPosition.right
                          : ItemPosition.topRight,
                      icon: FluentIcons.app_recent_20_regular,
                      title: context.locale.batched_apps_tile_title,
                      info: batchedAppsCount.toString(),
                      onTap: () => showDefaultBottomSheet(
                        context: context,
                        sliverBody: const SliverBatchedAppsList(),
                      ),
                    ),
                  ),
                ],
              ).sliver,

              /// Permission card
              const NotificationAccessPermissionCard(),

              /// Daily Schedules
              ContentSectionHeader(title: context.locale.schedules_heading)
                  .sliver,
              SliverSchedulesList(
                haveNotificationAccessPermission: havePermission,
              ),
            ],
          ),
        )
      ],
    );
  }
}
