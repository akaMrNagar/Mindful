import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class DefaultListTile extends StatelessWidget {
  /// Global list tile used throughout the app
  ///
  /// Alternative to [ListTile] as the list tile widget have some artifact when scrolling while in focus state
  const DefaultListTile({
    super.key,
    this.height,
    this.width,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.leadingIcon,
    this.titleText,
    this.subtitleText,
    this.color,
    this.accent,
    this.onPressed,
    this.switchValue,
    this.isSelected,
    this.enabled = true,
    this.isPrimary = false,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

  final double? height;
  final double? width;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final IconData? leadingIcon;
  final String? titleText;
  final String? subtitleText;
  final Color? color;
  final Color? accent;
  final bool? switchValue;
  final bool? isSelected;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isPrimary;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      circularRadius: (height ?? 64) <= 48 ? 14 : 18,
      color: isPrimary ? null : color ?? Colors.transparent,
      onPressed: enabled ? onPressed : null,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Leading widget
          leadingIcon != null
              ? Icon(
                  leadingIcon,
                  color:
                      enabled ? accent : Theme.of(context).colorScheme.outline,
                )
              : leading ?? 0.hBox,

          /// leading space
          if (leading != null || leadingIcon != null) const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title widget
                titleText != null
                    ? StyledText(
                        titleText!,
                        fontSize: 16,
                        fontWeight: isPrimary ? FontWeight.w500 : null,
                        color: enabled
                            ? accent
                            : Theme.of(context).colorScheme.outline,
                      )
                    : title ?? 0.vBox,

                /// Subtitle widget
                subtitleText != null
                    ? StyledText(
                        subtitleText!,
                        fontSize: 14,
                        isSubtitle: true,
                      )
                    : subtitle ?? 0.vBox,
              ],
            ),
          ),

          if (switchValue != null || isSelected != null || trailing != null)
            4.hBox,

          /// Trailing widget
          switchValue != null
              ? IgnorePointer(
                  child: Switch(
                    value: switchValue ?? false,
                    splashRadius: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: enabled ? (_) {} : null,
                  ),
                )
              : isSelected != null
                  ? IgnorePointer(
                      child: Checkbox(
                        value: isSelected,
                        splashRadius: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: enabled ? (_) {} : null,
                      ),
                    )
                  : trailing ?? 0.hBox,
        ],
      ),
    );
  }
}
