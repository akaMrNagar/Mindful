/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/screens/app_dashboard/app_internet_switcher.dart';
import 'package:mindful/ui/screens/app_dashboard/app_timer_picker.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// Displays available actions for the app in [AppDashboard]
class QuickActions extends ConsumerWidget {
  const QuickActions({super.key, required this.app});

  final AndroidApp app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiSliver(
      children: [
        /// App Timer tile
        AppTimerPicker(app: app).sliver,

        /// Internet access
        AppInternetSwitcher(app: app).sliver,

        /// Launch app button
        DefaultListTile(
          titleText: "Launch app",
          subtitleText: "Open ${app.name}",
          leadingIcon: FluentIcons.rocket_20_regular,
          onPressed: () async =>
              MethodChannelService.instance.openAppWithPackage(app.packageName),
        ).sliver,

        /// Launch app settings button
        DefaultListTile(
          titleText: "Go to app settings",
          subtitleText:
              "Manage app settings like notifications, permissions, storage and more.",
          leadingIcon: FluentIcons.launcher_settings_20_regular,
          onPressed: () async => MethodChannelService.instance
              .openAppSettingsForPackage(app.packageName),
        ).sliver,
      ],
    );
  }
}
