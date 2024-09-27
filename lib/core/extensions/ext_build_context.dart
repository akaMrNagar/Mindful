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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ExtBuildContext on BuildContext {
  /// Returns the [AppLocalizations] instance for the current context.
  /// Which can be used to access Locale Strings
  AppLocalizations get locale => AppLocalizations.of(this);

  void _showSnackBar({
    required IconData icon,
    required String info,
    required Color fgColor,
    required Color bgColor,
  }) {
    try {
      if (mounted) {
        ScaffoldMessenger.of(this).clearSnackBars();
        ScaffoldMessenger.of(this).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.horizontal,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            backgroundColor: bgColor,
            content: Row(
              children: [
                Icon(icon, color: fgColor),
                12.hBox,
                Expanded(
                  child: StyledText(
                    info,
                    color: fgColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          snackBarAnimationStyle: AnimationStyle(
            curve: Curves.elasticInOut,
            reverseCurve: Curves.elasticInOut,
            duration: 300.ms,
            reverseDuration: 300.ms,
          ),
        );
      }
    } catch (e) {
      debugPrint("ExtBuildContext._showSnackBar(): Exception $e");
    }
  }

  /// Shows information snackbar only if the widget is mounted so it is safe to use in async method
  void showSnackAlert(
    String info, {
    IconData icon = FluentIcons.warning_20_filled,
  }) {
    final bgColor = Theme.of(this).colorScheme.primary;
    final fgColor = Theme.of(this).colorScheme.onPrimary;
    _showSnackBar(
      icon: icon,
      info: info,
      fgColor: fgColor,
      bgColor: bgColor,
    );
  }
}
