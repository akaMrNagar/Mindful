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
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/apps/apps_info_provider.dart';
import 'package:mindful/providers/notifications/searched_notification_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/search_bar.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/modal_bottom_sheet.dart';
import 'package:mindful/ui/screens/notifications/notification_tile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchNotificationButton extends StatelessWidget {
  const SearchNotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      icon: const Icon(FluentIcons.search_20_filled),
      onPressed: () => showDefaultBottomSheet(
        context: context,
        initialSize: 0.75,
        sliverBody: const _SearchNotificationSheet(),
      ),
    );
  }
}

class _SearchNotificationSheet extends ConsumerStatefulWidget {
  const _SearchNotificationSheet();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchNotificationStateSheet();
}

class _SearchNotificationStateSheet
    extends ConsumerState<_SearchNotificationSheet> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(searchedNotificationsProvider(_query));
    final appInfo = ref.watch(appsInfoProvider);

    return MultiSliver(
      children: [
        /// Info
        StyledText(context.locale.search_notifications_sheet_info),

        12.vBox,

        /// Search bar
        PinnedHeaderSliver(
          child: Container(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            padding: const EdgeInsets.only(bottom: 6),
            child: DefaultSearchBar(
              hintText: context.locale.search_notifications_hint,
              onSubmitted: (v) => setState(() => _query = v),
            ),
          ),
        ),

        /// Header
        ContentSectionHeader(
          title: context.locale.notifications_tab_title,
          padding: const EdgeInsets.only(top: 12, bottom: 6),
        ),

        /// Notifications
        SliverAnimatedSwitcher(
          duration: 500.ms,
          child: notifications.hasValue && appInfo.hasValue
              ? SliverImplicitlyAnimatedList(
                  items: notifications.value!,
                  keyBuilder: (e) => "${e.packageName}: ${e.timeStamp}",
                  itemBuilder: (context, i, notification, position) {
                    return appInfo.value!.containsKey(notification.packageName)
                        ? NotificationTile(
                            position: position,
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHigh,
                            leading: ApplicationIcon(
                              appInfo:
                                  appInfo.value![notification.packageName]!,
                            ),
                            notification: notification,
                          )
                        : 0.vBox;
                  },
                )
              : const SliverShimmerList(
                  includeLeading: true,
                  includeSubtitle: true,
                  includeTrailing: true,
                ),
        )
      ],
    );
  }
}
