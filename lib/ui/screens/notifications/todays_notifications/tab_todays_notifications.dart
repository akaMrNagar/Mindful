import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/providers/notifications/dated_notifications_provider.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/screens/notifications/sliver_notifications_list.dart';

class TabTodaysNotifications extends ConsumerStatefulWidget {
  const TabTodaysNotifications({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TabTodaysNotificationsState();
}

class _TabTodaysNotificationsState
    extends ConsumerState<TabTodaysNotifications> {
  DateTimeRange _last24Hours = DateTime.now().last24Hours;

  @override
  void initState() {
    super.initState();

    /// Mark notifications as read
    Future.delayed(
      5.seconds,
      () {
        if (!mounted) return;
        ref
            .read(datedNotificationsProvider(_last24Hours).notifier)
            .markNotificationsAsRead();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultRefreshIndicator(
      onRefresh: () async {
        if (mounted) setState(() => _last24Hours = DateTime.now().last24Hours);
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Notifications
          SliverNotificationsList(
            timeRange: _last24Hours,
            header: context.locale.last_24_hours_heading,
          ),

          /// padding
          const SliverTabsBottomPadding(),
        ],
      ),
    );
  }
}
