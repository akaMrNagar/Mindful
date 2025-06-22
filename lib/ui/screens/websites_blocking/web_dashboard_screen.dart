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
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/ui/common/scaffold_shell.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/screens/websites_blocking/web_dashboard_restrictions.dart';
import 'package:mindful/ui/screens/app_dashboard/emergency_fab.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WebDashboardScreen extends ConsumerStatefulWidget {
  /// Web dashboard screen containing detailed usage along with quick actions based on the provided app
  const WebDashboardScreen({
    super.key,
    required this.host,
  });

  final String host;

  @override
  ConsumerState<WebDashboardScreen> createState() => _WebDashboardScreenState();
}

class _WebDashboardScreenState extends ConsumerState<WebDashboardScreen> {
  int webTimeSpent = 0;

  @override
  void initState() {
    super.initState();
    MethodChannelService.instance.getWebTimeSpent(widget.host).then((value) {
      setState(() {
        webTimeSpent = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      enabled: false,
      ignorePointers: false,
      child: ScaffoldShell(
        appBarExpandedHeight: 220,
        items: [
          NavbarItem(
             icon: FluentIcons.data_pie_20_regular,
             filledIcon: FluentIcons.data_pie_20_filled,
             titleText: widget.host,
             fab: const EmergencyFAB(),
             titleBuilder: (percentage) =>
                 _buildTitle(percentage, widget.host),
             sliverBody: CustomScrollView(
               physics: const BouncingScrollPhysics(),
               slivers: [
                 20.vSliverBox,
                 WebDashboardRestrictions(
                   host: widget.host,
                   webTimeSpent: webTimeSpent,
                 ),
                 const SliverTabsBottomPadding(),
               ],
             ),
          ),
        ],
      ),
    );
  }

  Column _buildTitle(
    double percentage,
    String host,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarTitle(
          titleText: host
        ),
      ],
    );
  }
}
