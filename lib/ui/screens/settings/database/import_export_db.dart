/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/dialogs/time_countdown_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ImportExportDb extends ConsumerStatefulWidget {
  const ImportExportDb({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImportExportDbState();
}

class _ImportExportDbState extends ConsumerState<ImportExportDb> {
  bool _isExporting = false;
  bool _isImporting = false;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        ContentSectionHeader(title: context.locale.database_tab_title).sliver,

        /// Import
        DefaultHero(
          tag: HeroTags.importDatabaseTileTag,
          child: DefaultListTile(
            position: ItemPosition.top,
            titleText: context.locale.import_db_tile_title,
            subtitleText: context.locale.import_db_tile_subtitle,
            leadingIcon: FluentIcons.arrow_download_20_regular,
            trailing: _isImporting
                ? const SizedBox.square(
                    dimension: 24,
                    child:
                        CircularProgressIndicator(strokeCap: StrokeCap.round),
                  )
                : const Icon(FluentIcons.chevron_right_20_regular),
            onPressed: _importDatabase,
          ),
        ).sliver,

        /// Export
        DefaultListTile(
          position: ItemPosition.bottom,
          titleText: context.locale.export_db_tile_title,
          subtitleText: context.locale.export_db_tile_subtitle,
          leadingIcon: FluentIcons.arrow_upload_20_regular,
          trailing: _isExporting
              ? const SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(strokeCap: StrokeCap.round),
                )
              : const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: _exportDatabase,
        ).sliver,
      ],
    );
  }

  void _importDatabase() async {
    try {
      setState(() => _isImporting = true);

      /// Original DB file
      final originalDbFile = File(await getSqliteDbPath());
      final result = await FilePicker.platform.pickFiles(
        allowCompression: false,
        type: FileType.any,
      );

      if (result == null ||
          result.count < 1 ||
          result.files.first.extension != 'sqlite') {
        throw Exception(
          'Either selected file is null or invalid extension',
        );
      }

      /// Backup DB file
      final backupFile = File(result.files.first.xFile.path);

      if (await backupFile.exists()) {
        /// dispose, clean, copy
        await DriftDbService.instance.driftDb.close();
        await originalDbFile.delete();
        await backupFile.copy(originalDbFile.path);

        /// let user know about the restart
        mounted
            ? await showCountDownDialog(
                context: context,
                heroTag: HeroTags.importDatabaseTileTag,
                timerDuration: 5.seconds,
                title: context.locale.app_restart_dialog_title,
                info: context.locale.app_restart_dialog_info,
                icon: FluentIcons.arrow_reset_20_filled,
                onCountDownFinish: MethodChannelService.instance.restartApp,
              )
            : await MethodChannelService.instance.restartApp();
      } else {
        throw Exception('Backup file does not exist');
      }
    } catch (e) {
      debugPrint("Error occurred while importing database: $e");
      if (!mounted) return;
      context.showSnackAlert(context.locale.operation_failed_snack_alert);
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  void _exportDatabase() async {
    try {
      setState(() => _isExporting = true);

      /// Get the database path: /data/user/0/com.mindful.android/app_flutter/Mindful.sqlite
      final dbFile = File(await getSqliteDbPath());
      if (!await dbFile.exists()) {
        throw Exception('Database file not found at ${dbFile.path}');
      }

      /// export to file
      final dbFileBytes = await dbFile.readAsBytes();
      final now = DateTime.now();
      final resultPath = await FilePicker.platform.saveFile(
        fileName:
            "Mindful-Backup-${now.year}${now.month}${now.day}-${now.hour}${now.minute}${now.second}.sqlite",
        bytes: Uint8List.fromList(dbFileBytes),
      );

      /// user aborted
      if (resultPath == null) {
        throw Exception('User aborted the exporting operation');
      }
    } catch (e) {
      debugPrint("Error occurred while exporting database: $e");
      if (!mounted) return;
      context.showSnackAlert(context.locale.operation_failed_snack_alert);
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }
}
