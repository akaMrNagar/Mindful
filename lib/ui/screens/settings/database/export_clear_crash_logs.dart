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
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/dialogs/modal_bottom_sheet.dart';
import 'package:mindful/ui/screens/settings/database/sliver_crash_logs_list.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ExportClearCrashLogs extends ConsumerStatefulWidget {
  const ExportClearCrashLogs({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExportClearCrashLogsState();
}

class _ExportClearCrashLogsState extends ConsumerState<ExportClearCrashLogs> {
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        ContentSectionHeader(title: context.locale.crash_logs_heading).sliver,
        StyledText(context.locale.crash_logs_info).sliver,
        16.vSliverBox,

        /// Export
        DefaultListTile(
          position: ItemPosition.top,
          titleText: context.locale.crash_logs_export_tile_title,
          subtitleText: context.locale.crash_logs_export_tile_subtitle,
          leadingIcon: FluentIcons.arrow_upload_20_regular,
          trailing: _isExporting
              ? const SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(strokeCap: StrokeCap.round),
                )
              : const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: _shareLogs,
        ).sliver,

        /// view
        DefaultListTile(
          position: ItemPosition.mid,
          titleText: context.locale.crash_logs_view_tile_title,
          subtitleText: context.locale.crash_logs_view_tile_subtitle,
          leadingIcon: FluentIcons.notepad_20_regular,
          trailing: const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: () => showDefaultBottomSheet(
            context: context,
            headerTitle: context.locale.crash_logs_heading,
            sliverBody: const SliverCrashLogsList(),
          ),
        ).sliver,

        /// Clear
        DefaultHero(
          tag: HeroTags.clearCrashLogsTileTag,
          child: DefaultListTile(
            position: ItemPosition.bottom,
            titleText: context.locale.crash_logs_clear_tile_title,
            subtitleText: context.locale.crash_logs_clear_tile_subtitle,
            leadingIcon: FluentIcons.delete_lines_20_regular,
            onPressed: _clearLogs,
          ),
        ).sliver,
      ],
    );
  }

  void _shareLogs() async {
    try {
      setState(() => _isExporting = true);

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

      /// Create file and write logs
      final now = DateTime.now();
      final resultPath = await FilePicker.platform.saveFile(
        fileName:
            "Mindful-Logs-${now.year}${now.month}${now.day}-${now.hour}${now.minute}${now.second}.json",
        bytes: Uint8List.fromList(utf8.encode(jsonString)),
      );

      /// user aborted
      if (resultPath == null) {
        throw Exception('User aborted the exporting operation');
      }
    } catch (e) {
      debugPrint("Failed to export crash logs to a file : $e");
      if (!mounted) return;
      context.showSnackAlert(context.locale.operation_failed_snack_alert);
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  void _clearLogs() async {
    final confirm = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.clearCrashLogsTileTag,
      title: context.locale.crash_logs_clear_tile_title,
      info: context.locale.crash_logs_clear_dialog_info,
      icon: FluentIcons.delete_lines_20_filled,
      positiveLabel: context.locale.crash_logs_clear_dialog_button_clear_anyway,
    );

    if (confirm) {
      await MethodChannelService.instance.clearNativeCrashLogs();
      await DriftDbService.instance.driftDb.dynamicRecordsDao.clearCrashLogs();
    }
  }
}
