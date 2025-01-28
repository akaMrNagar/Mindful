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

class DefaultSlideToRemove extends StatelessWidget {
  const DefaultSlideToRemove({
    required super.key,
    required this.child,
    required this.onDismiss,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      enabled: enabled,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            autoClose: true,
            label: context.locale.dialog_button_remove,
            icon: FluentIcons.delete_20_filled,
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            onPressed: (_) => onDismiss(),
          ),
        ],
      ),
      child: child,
    );
  }
}
