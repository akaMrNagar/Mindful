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
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/notifications/dated_notifications_provider.dart';
import 'package:mindful/providers/notifications/notification_settings_provider.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/go_to_badge_icon.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/status_label.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:mindful/ui/dialogs/modal_bottom_sheet.dart';
import 'package:mindful/ui/permissions/notification_access_permission_card.dart';
import 'package:mindful/ui/screens/home/notifications/sliver_batched_apps_list.dart';
import 'package:mindful/ui/screens/home/notifications/sliver_schedules_list.dart';

class TabNotifications extends ConsumerStatefulWidget {
  const TabNotifications({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TabNotificationsState();
}

class _TabNotificationsState extends ConsumerState<TabNotifications> {
  final DateTimeRange last24Hours = DateTime.now().last24Hours;

  @override
  Widget build(
    BuildContext context,
  ) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveNotificationAccessPermission));

    final settings = ref.watch(notificationSettingsProvider);

    final notificationsCount = ref.watch(datedNotificationsProvider(last24Hours)
            .select((v) => v.value?.length)) ??
        0;

    return DefaultRefreshIndicator(
      onRefresh: ref
          .read(datedNotificationsProvider(last24Hours).notifier)
          .refreshNotifications,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          StatusLabel(
            label: "Work in progress",
            accent: Theme.of(context).colorScheme.error,
          ).sliver,

          8.vSliverBox,

          /// Information about notification groups
          StyledText(context.locale.notifications_tab_info).sliver,

          16.vSliverBox,

          /// Upcoming notifications and Batched apps
          Row(
            children: [
              /// Upcoming notifications
              Expanded(
                child: UsageGlanceCard(
                  isPrimary: true,
                  badge: const GoToBadgeIcon(),
                  position: ItemPosition.topLeft,
                  icon: FluentIcons.alert_badge_20_regular,
                  title: context.locale.notifications_tab_title,
                  info: notificationsCount.toString(),
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRoutes.notificationsPath),
                ),
              ),
              4.hBox,

              /// Batched apps
              Expanded(
                child: UsageGlanceCard(
                  isPrimary: true,
                  badge: const GoToBadgeIcon(),
                  position: ItemPosition.topRight,
                  icon: FluentIcons.app_recent_20_regular,
                  title: context.locale.batched_apps_tile_title,
                  info: settings.batchedApps.length.toString(),
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

          /// Unbatched history
          DefaultListTile(
            enabled: havePermission,
            position: ItemPosition.bottom,
            switchValue: settings.storeNonBatchedToo,
            titleText: context.locale.store_all_tile_title,
            subtitleText: context.locale.store_all_tile_subtitle,
            onPressed: ref
                .read(notificationSettingsProvider.notifier)
                .toggleStoreNonBatched,
          ).sliver,

          /// Daily Schedules
          ContentSectionHeader(title: context.locale.schedules_heading).sliver,
          SliverSchedulesList(
            haveNotificationAccessPermission: havePermission,
          ),

          const SliverTabsBottomPadding(),
        ],
      ),
    );
  }
}
