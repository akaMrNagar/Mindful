import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/styled_text.dart';

extension ExtBuildContext on BuildContext {
  void _showSnackBar({
    required IconData icon,
    required String error,
    required Color fgColor,
    required Color bgColor,
    bool showCopyAction = false,
  }) {
    try {
      if (mounted) {
        ScaffoldMessenger.of(this).showSnackBar(
          SnackBar(
            backgroundColor: bgColor,
            action: showCopyAction
                ? SnackBarAction(
                    label: "Copy",

                    backgroundColor: Theme.of(this).colorScheme.primary,
                    textColor: Theme.of(this).colorScheme.onPrimary,
                    // textColor: fgColor,
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: error),
                      );
                    },
                  )
                : null,
            content: Row(
              children: [
                Icon(icon, color: fgColor),
                12.hBox,
                Expanded(child: StyledText(error, color: fgColor))
              ],
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint("ExtBuildContext._showSnackBar(): Exception $e");
    }
  }

  /// Shows error snackbar only if the widget is mounted so it is safe to use in async method
  void showSnackError(String error) {
    final bgColor = Theme.of(this).colorScheme.errorContainer;
    final fgColor = Theme.of(this).colorScheme.onErrorContainer;
    _showSnackBar(
      icon: FluentIcons.bug_20_regular,
      error: error,
      fgColor: fgColor,
      bgColor: bgColor,
      showCopyAction: true,
    );
  }

  // /// Shows information snackbar only if the widget is mounted so it is safe to use in async method
  // void showSnackInfo(
  //   String info, {
  //   IconData icon = FluentIcons.info_20_regular,
  // }) {
  //   final bgColor = Theme.of(this).colorScheme.secondaryContainer;
  //   final fgColor = Theme.of(this).colorScheme.onSecondaryContainer;
  //   _showSnackBar(
  //     icon: icon,
  //     error: info,
  //     fgColor: fgColor,
  //     bgColor: bgColor,
  //   );
  // }

  void showSnackAlert(
    String info, {
    IconData icon = FluentIcons.prohibited_20_regular,
  }) {
    final bgColor = Theme.of(this).colorScheme.secondaryContainer;
    final fgColor = Theme.of(this).colorScheme.onSecondaryContainer;
    _showSnackBar(
      icon: icon,
      error: info,
      fgColor: fgColor,
      bgColor: bgColor,
    );
  }
}
