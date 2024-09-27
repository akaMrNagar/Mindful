/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:convert';
import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/permissions/battery_permission_tile.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:path_provider/path_provider.dart';

class TabAdvance extends ConsumerWidget {
  const TabAdvance({super.key});

  void _openAutoStartSettings(BuildContext context) async {
    final success = await MethodChannelService.instance.openAutoStartSettings();

    if (!success && context.mounted) {
      context.showSnackAlert(
        "This device does not support automatic startup management.",
      );
    }
  }

  void _shareLogs(BuildContext context) async {
    try {
      final logs = await IsarDbService.instance.loadCrashLogs();
      final deviceInfo = await MethodChannelService.instance.getDeviceInfoMap();

      final crashLogMap = {
        "Manufacturer": deviceInfo['Manufacturer'] ?? '',
        "Model": deviceInfo['Model'] ?? '',
        "Android Version": deviceInfo['Android Version'] ?? '',
        "SDK Version": deviceInfo['SDK Version'] ?? '',
        'Crash Logs': logs.map((e) => e.toLogMap()).toList()
      };

      final jsonString = jsonEncode(crashLogMap);

      // Get the app's cache directory
      final dir = await getApplicationCacheDirectory();

      // Define the logs directory path
      final logsDir = Directory('${dir.path}/logs');

      // Check if the logs directory exists, if not, create it
      if (!await logsDir.exists()) {
        await logsDir.create(recursive: true);
      }

      // Define the file path for the logs file
      final file = File('${logsDir.path}/mindful_crash_logs.json');

      // Write the JSON string to the file
      await file.writeAsString(jsonString);

      /// Share file using native method
      await MethodChannelService.instance.shareFile(file.path);
    } catch (e) {
      if (context.mounted) {
        context.showSnackAlert("Something went wrong!!");
      }
    }
  }

  void _clearLogs(BuildContext context) async {
    final confirm = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.clearCrashLogsTileTag,
      title: "Clear logs",
      info: "Are you sure you wish to clear all crash logs from the database?",
      icon: FluentIcons.delete_lines_20_filled,
      positiveLabel: "Clear anyway",
    );

    if (confirm) {
      await IsarDbService.instance.clearCrashLogs();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        const SliverFlexibleAppBar(title: "Advance"),

        const SliverContentTitle(title: "Service"),

        /// Battery
        StyledText(context.locale.permission_battery_optimization_info).sliver,
        6.vSliverBox,

        /// Battery permission
        const BatteryPermissionTile(),

        20.vSliverBox,
        const StyledText(
          "If you are still experiencing same issues, even after granting ignore battery optimization, then consider whitelisting Mindful.",
        ).sliver,
        6.vSliverBox,
        DefaultListTile(
          leadingIcon: FluentIcons.leaf_three_20_regular,
          titleText: "Whitelist Mindful",
          subtitleText: "Allow Mindful to auto start.",
          trailing: const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: () => _openAutoStartSettings(context),
        ).sliver,

        20.vSliverBox,
        const SliverContentTitle(title: "Crash logs"),
        const StyledText(
          "If you encounter any issue, you can report it on GitHub along with the log file. The file will include details such as your device's manufacturer, model, Android version, SDK version, and crash logs. This information will help us identify and resolve the problem more effectively.",
        ).sliver,

        16.vSliverBox,
        DefaultListTile(
          titleText: "Share crash logs",
          subtitleText: "Share crash logs as a json file.",
          leadingIcon: FluentIcons.share_android_20_regular,
          trailing: const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: () => _shareLogs(context),
        ).sliver,

        2.vSliverBox,
        DefaultHero(
          tag: HeroTags.clearCrashLogsTileTag,
          child: DefaultListTile(
            titleText: "Clear logs",
            subtitleText: "Delete all crash logs from database.",
            leadingIcon: FluentIcons.delete_lines_20_regular,
            onPressed: () => _clearLogs(context),
          ),
        ).sliver,

        const SliverTabsBottomPadding()
      ],
    );
  }
}
