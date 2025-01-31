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
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/ui/common/styled_text.dart';

class DefaultSlideToRemove extends StatelessWidget {
  const DefaultSlideToRemove({
    required super.key,
    required this.child,
    required this.onDismiss,
    this.enabled = true,
    this.removable = true,
  });

  final Widget child;
  final bool enabled;
  final bool removable;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      enabled: enabled,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          CustomSlidableAction(
            autoClose: true,
            backgroundColor: removable
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).focusColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Icon
                Icon(
                  removable
                      ? FluentIcons.delete_20_filled
                      : FluentIcons.delete_off_20_filled,
                  color: removable
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).disabledColor,
                  size: removable ? 20 : 24,
                ),

                /// Text
                if (removable)
                  StyledText(
                    context.locale.dialog_button_remove,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onError,
                  ),
              ],
            ),
            onPressed: (_) => removable ? onDismiss() : null,
          ),
        ],
      ),
      child: child,
    );
  }
}
