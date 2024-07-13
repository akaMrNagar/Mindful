import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
            duration: 7.seconds,
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
                12.hBox(),
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
      icon: FluentIcons.error_circle_20_regular,
      error: error,
      fgColor: fgColor,
      bgColor: bgColor,
      showCopyAction: true,
    );
  }

  /// Shows information snackbar only if the widget is mounted so it is safe to use in async method
  void showSnackInfo(String error) {
    final bgColor = Theme.of(this).colorScheme.secondaryContainer;
    final fgColor = Theme.of(this).colorScheme.onSecondaryContainer;
    _showSnackBar(
      icon: FluentIcons.error_circle_20_regular,
      error: error,
      fgColor: fgColor,
      bgColor: bgColor,
    );
  }
}
