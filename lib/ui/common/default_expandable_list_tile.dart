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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';

/// Global expandable list tile used throughout the app
///
/// Extending the functionality of [DefaultListTile] with expandable content
class DefaultExpandableListTile extends StatefulWidget {
  const DefaultExpandableListTile({
    super.key,
    required this.contentPosition,
    required this.content,
    this.leading,
    this.title,
    this.subtitle,
    this.leadingIcon,
    this.titleText,
    this.subtitleText,
    this.color,
    this.accent,
    this.position = ItemPosition.none,
    this.enabled = true,
    this.isPrimary = false,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget content;
  final IconData? leadingIcon;
  final String? titleText;
  final String? subtitleText;
  final Color? color;
  final Color? accent;
  final ItemPosition position;
  final ItemPosition contentPosition;
  final bool enabled;
  final bool isPrimary;

  @override
  State<DefaultExpandableListTile> createState() =>
      _DefaultExpandableListTileState();
}

class _DefaultExpandableListTileState extends State<DefaultExpandableListTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Tile
        DefaultListTile(
          leading: widget.leading,
          title: widget.title,
          subtitle: widget.subtitle,
          leadingIcon: widget.leadingIcon,
          titleText: widget.titleText,
          subtitleText: widget.subtitleText,
          color: widget.color,
          position: widget.position,
          enabled: widget.enabled,
          isPrimary: widget.isPrimary,
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          trailing: AnimatedRotation(
            duration: 250.ms,
            turns: _isExpanded ? 0.5 : 1,
            child: Icon(
              FluentIcons.chevron_down_20_filled,
              color: widget.enabled ? null : Theme.of(context).disabledColor,
            ),
          ),
        ),

        /// Animated Expanded Content
        RoundedContainer(
          borderRadius: getBorderRadiusFromPosition(widget.contentPosition),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(bottom: _isExpanded ? 2 : 0),
          child: FractionallySizedBox(
            widthFactor: 1,
            child: AnimatedSize(
              alignment: Alignment.topCenter,
              duration: 250.ms,
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: widget.content,
                    )
                  : const SizedBox.shrink(), // Collapsed state
            ),
          ),
        ),
      ],
    );
  }
}
