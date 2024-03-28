import 'package:flutter/material.dart';
import 'package:mindful/ui/common/components/rounded_list_tile.dart';

class SwitchableListTile extends StatelessWidget {
  const SwitchableListTile({
    super.key,
    required this.value,
    this.enabled = true,
    this.onPressed,
    this.outlined = true,
    this.leading,
    this.title,
    this.subTitle,
  });

  final bool value;
  final bool enabled;
  final bool outlined;
  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return RoundedListTile(
      // height: 72,

      leading: leading,
      title: title,
      subTitle: subTitle,
      outlined: outlined,
      onPressed: enabled ? onPressed : null,
      trailing: IgnorePointer(
        child: Switch(
          activeColor: const Color(0xFF0EABE1),
          value: value,
          onChanged: enabled ? (_) {} : null,
        ),
      ),
    );
  }
}
