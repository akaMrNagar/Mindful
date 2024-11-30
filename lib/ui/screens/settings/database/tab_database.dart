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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/device_info_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:path_provider/path_provider.dart';

class TabDatabase extends ConsumerWidget {
  const TabDatabase({super.key});

  void _shareLogs(BuildContext context, WidgetRef ref) async {
    try {
      final logs = await DriftDbService.instance.driftDb.dynamicRecordsDao
          .fetchCrashLogs();
      final deviceInfo = ref.read(deviceInfoProvider).value;

      final crashLogMap = {
        "Manufacturer": deviceInfo?.manufacturer,
        "Model": deviceInfo?.model,
        "Android Version": deviceInfo?.androidVersion,
        "SDK Version": deviceInfo?.sdkVersion,
        'Crash Logs': logs.map((e) => e.toJson()).toList()
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
        context.showSnackAlert(
          context.locale.crash_logs_share_failed_snack_alert,
        );
      }
    }
  }

  void _clearLogs(BuildContext context) async {
    final confirm = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.clearCrashLogsTileTag,
      title: context.locale.crash_logs_clear_tile_title,
      info: context.locale.crash_logs_clear_dialog_info,
      icon: FluentIcons.delete_lines_20_filled,
      positiveLabel: context.locale.crash_logs_clear_dialog_button_clear_anyway,
    );

    if (confirm) {
      await DriftDbService.instance.driftDb.dynamicRecordsDao.clearCrashLogs();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Backup and reset

        /// Crash logs
        ContentSectionHeader(title: context.locale.crash_logs_heading).sliver,
        StyledText(context.locale.crash_logs_info).sliver,

        16.vSliverBox,
        DefaultListTile(
          position: ItemPosition.start,
          titleText: context.locale.crash_logs_share_tile_title,
          subtitleText: context.locale.crash_logs_share_tile_subtitle,
          leadingIcon: FluentIcons.share_android_20_regular,
          trailing: const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: () => _shareLogs(context, ref),
        ).sliver,

        DefaultHero(
          tag: HeroTags.clearCrashLogsTileTag,
          child: DefaultListTile(
            position: ItemPosition.end,
            titleText: context.locale.crash_logs_clear_tile_title,
            subtitleText: context.locale.crash_logs_clear_tile_subtitle,
            leadingIcon: FluentIcons.delete_lines_20_regular,
            onPressed: () => _clearLogs(context),
          ),
        ).sliver,

        const SliverTabsBottomPadding()
      ],
    );
  }
}
