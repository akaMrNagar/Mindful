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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/ui/common/default_list_tile.dart';

/// Global expandable list tile used throughout the app
///
/// Extending the functionality of [DefaultListTile] with expandable content
class DefaultExpandableListTile extends StatefulWidget {
  const DefaultExpandableListTile({
    super.key,
    required this.content,
    this.leading,
    this.title,
    this.subtitle,
    this.leadingIcon,
    this.titleText,
    this.subtitleText,
    this.color,
    this.accent,
    this.canExpand,
    this.position = ItemPosition.none,
    this.enabled = true,
    this.isPrimary = false,
  });

  final IconData? leadingIcon;
  final Widget? leading;
  final String? titleText;
  final Widget? title;
  final String? subtitleText;
  final Widget? subtitle;
  final Color? color;
  final Color? accent;
  final ItemPosition position;
  final Widget content;
  final bool enabled;
  final bool isPrimary;
  final bool Function()? canExpand;

  @override
  State<DefaultExpandableListTile> createState() =>
      _DefaultExpandableListTileState();
}

class _DefaultExpandableListTileState extends State<DefaultExpandableListTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final expandedPosition = widget.position == ItemPosition.none
        ? ItemPosition.top
        : widget.position == ItemPosition.bottom
            ? ItemPosition.mid
            : widget.position;

    final contentPosition = widget.position == ItemPosition.none
        ? ItemPosition.bottom
        : widget.position == ItemPosition.bottom
            ? ItemPosition.bottom
            : ItemPosition.mid;

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
          accent: widget.accent,
          position: _isExpanded ? expandedPosition : widget.position,
          enabled: widget.enabled,
          isPrimary: widget.isPrimary,
          onPressed: () {
            if (_isExpanded || (widget.canExpand?.call() ?? true)) {
              setState(() => _isExpanded = !_isExpanded);
            }
          },
          trailing: AnimatedRotation(
            duration: AppConstants.defaultAnimDuration,
            turns: _isExpanded ? 0.5 : 1,
            child: Icon(
              FluentIcons.chevron_down_20_filled,
              color: widget.enabled ? null : Theme.of(context).disabledColor,
            ),
          ),
        ),

        /// Animated Expanded Content
        ClipRRect(
          borderRadius: getBorderRadiusFromPosition(contentPosition),
          child: FractionallySizedBox(
            widthFactor: 1,
            child: AnimatedSize(
              alignment: Alignment.topCenter,
              duration: AppConstants.defaultAnimDuration,
              curve: AppConstants.defaultCurve,
              child: _isExpanded
                  ? widget.content
                  : const SizedBox.shrink(), // Collapsed state
            ),
          ),
        ),
      ],
    );
  }
}
