// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TabDatabase extends ConsumerStatefulWidget {
  const TabDatabase({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabDatabaseState();
}

class _TabDatabaseState extends ConsumerState<TabDatabase> {
  bool _isBackingUpDb = false;
  bool _isRestoringDb = false;
  bool _isResettingDb = false;

  void _backup() async {
    try {
      setState(() => _isBackingUpDb = true);
      String? path = await FilePicker.platform.getDirectoryPath();

      if (path != null) {
        // Create a path using date
        final now = DateTime.now().millisecondsSinceEpoch;

        // Output file => /storage/emulated/0/Documents/Mindful-Backup-2024-07-13.enc
        final dbFilePath = "$path/Mindful-Backup-$now.isar";
        await ref.read(settingsProvider.notifier).backupDatabase(dbFilePath);

        // Show successful message
        context.showSnackInfo(
          "Backup successful. The database has been exported to $dbFilePath.",
        );
      }
    } catch (e) {
      context.showSnackError(e.toString());
      debugPrint("Backup Error: ${e.toString()}");
    } finally {
      if (mounted) {
        setState(() => _isBackingUpDb = false);
      }
    }
  }

  void _restore() async {
    try {
      setState(() => _isRestoringDb = true);
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: false,
        withData: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final dbFile = result.files.first;

        await ref.read(settingsProvider.notifier).restoreDatabase(dbFile);
        await Future.delayed(2.seconds);
        await MethodChannelService.instance.restartApp();
      }
    } catch (e) {
      context.showSnackError(e.toString());
      debugPrint("Restore Error: ${e.toString()}");
    } finally {
      if (mounted) {
        setState(() => _isRestoringDb = false);
      }
    }
  }

  void _reset() async {
    try {
      if (!await showConfirmationDialog(
        context: context,
        heroTag: "confirmDatabaseReset",
        title: "Reset database",
        info:
            "This operation is irreversible and cannot be undone unless a backup is available. The application will automatically restart shortly after completion. Are you sure you want to reset the database?",
        icon: FluentIcons.book_database_20_regular,
        positiveLabel: "Reset",
      )) return;

      setState(() => _isResettingDb = true);

      await ref.read(settingsProvider.notifier).resetDatabase();
      await Future.delayed(2.seconds);
      await MethodChannelService.instance.restartApp();
    } catch (e) {
      context.showSnackError(e.toString());
      debugPrint("Reset Error: ${e.toString()}");
    } finally {
      if (mounted) {
        setState(() => _isResettingDb = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: CustomScrollView(
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "Database"),

          /// Backup & restore
          const SliverContentTitle(title: "Backup and restore"),

          /// Backup
          DefaultListTile(
            titleText: "Backup",
            subtitleText: "Export database to the external storage",
            trailing: _isBackingUpDb
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  )
                : null,
            onPressed: _backup,
          ).toSliverBox(),

          /// Restore
          DefaultListTile(
            titleText: "Restore",
            subtitleText:
                "Import database from the external storage.\nThe app will automatically restart briefly after completion.",
            trailing: _isRestoringDb
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  )
                : null,
            onPressed: _restore,
          ).toSliverBox(),

          /// Reset settings
          const SliverContentTitle(title: "Reset"),

          /// Reset warning
          StyledText(
            "Danger",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.error,
          ).toSliverBox(),

          StyledText(
            "This operation is irreversible and cannot be undone unless a backup is available. The app will automatically restart briefly after completion.",
            color: Theme.of(context).colorScheme.error,
          ).toSliverBox(),

          8.vSliverBox(),

          /// Reset
          Hero(
            tag: "confirmDatabaseReset",
            child: DefaultListTile(
              leadingIcon: FluentIcons.book_database_20_regular,
              titleText: "Reset",
              subtitleText: "Delete app database like a fresh install",
              trailing: _isResettingDb
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : null,
              onPressed: _reset,
            ),
          ).toSliverBox(),

          SliverAnimatedPaintExtent(
            duration: 250.ms,
            child: const Visibility(
              visible: true,
              child: Column(
                children: [],
              ),
            ).toSliverBox(),
          )
        ],
      ),
    );
  }
}
