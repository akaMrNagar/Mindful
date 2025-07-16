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
import 'package:mindful/l10n/generated/app_localizations.dart';
import 'package:mindful/ui/common/styled_text.dart';

extension ExtBuildContext on BuildContext {
  /// Returns the [AppLocalizations] instance for the current context.
  /// Which can be used to access Locale Strings
  AppLocalizations get locale => AppLocalizations.of(this);

  /// Either go back if [Navigator] can pop or push replace [replacingRoute]
  Future<bool> popOrPushReplace<T>(String replacingRoute) async {
    try {
      if (Navigator.of(this).canPop()) {
        return await Navigator.of(this).maybePop();
      } else {
        await Navigator.of(this).pushReplacementNamed(replacingRoute);
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  /// Resolve the parameter from the modal route settings arguments
  /// and returns the nullable generic of type [T].
  T? resolveParam<T>(String key) {
    try {
      final args = ModalRoute.of(this)?.settings.arguments;
      if (args is Map) {
        final value = args[key]?.toString();

        if (value != null) {
          if (T == int) {
            return int.tryParse(value) as T?;
          } else if (T == double) {
            return double.tryParse(value) as T?;
          } else if (T == bool) {
            return (value.toLowerCase() == 'true') as T?;
          } else if (T == DateTime) {
            return DateTime.tryParse(value) as T?;
          } else if (T == String) {
            return value as T?;
          }
        }
      }
    } catch (e) {
      debugPrint("Failed to resolve parameter with key `$key`");
    }
    return null;
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

  void _showSnackBar({
    required IconData icon,
    required String info,
    required Color fgColor,
    required Color bgColor,
  }) {
    try {
      if (mounted) {
        ScaffoldMessenger.of(this)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              dismissDirection: DismissDirection.down,
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
              curve: Curves.easeOutBack,
              reverseCurve: Curves.easeInBack,
              duration: 300.ms,
              reverseDuration: 300.ms,
            ),
          );
      }
    } catch (e) {
      debugPrint("ExtBuildContext._showSnackBar(): Exception $e");
    }
  }
}
