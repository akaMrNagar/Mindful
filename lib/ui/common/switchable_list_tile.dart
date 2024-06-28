import 'package:flutter/material.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/stateful_text.dart';

class SwitchableListTile extends StatelessWidget {
  const SwitchableListTile({
    super.key,
    required this.value,
    this.enabled = true,
    this.onPressed,
    this.isPrimary = false,
    this.leadingIcon,
    this.titleText,
    this.subTitleText,
  });

  final bool value;
  final bool enabled;
  final bool isPrimary;
  final IconData? leadingIcon;
  final String? titleText;
  final String? subTitleText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: isPrimary ? null : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      onPressed: enabled ? onPressed : null,
      child: ListTileSkeleton(
        /// Leading icon
        leading: leadingIcon != null
            ? Icon(
                leadingIcon,
                color: enabled ? null : Theme.of(context).disabledColor,
              )
            : null,

        /// Title text
        title: titleText != null
            ? StatefulText(
                titleText!,
                fontSize: 16,
                isActive: enabled,
                fontWeight: isPrimary ? FontWeight.w500 : null,
              )
            : null,

        /// Subtitle text
        subtitle: subTitleText != null
            ? StatefulText(
                subTitleText!,
                isActive: false,
                fontSize: 14,
              )
            : null,

        /// Trailing switch
        trailing: IgnorePointer(
          child: Switch(
            value: value,
            splashRadius: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: enabled ? (_) {} : null,
          ),
        ),
      ),
    );
  }
}
