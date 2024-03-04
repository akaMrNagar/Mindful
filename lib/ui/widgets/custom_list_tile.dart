import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/widgets/buttons.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.outlined = true,
    this.leading,
    this.title,
    this.subTitle,
    this.trailing,
    this.onPressed,
    this.margin = const EdgeInsets.only(bottom: 4, right: 6),
  });

  final bool? outlined;
  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return outlined ?? true
        ? TertiaryButton(
            onPressed: onPressed,
            margin: margin,
            child: _buildChild(),
          )
        : SecondaryButton(
            onPressed: onPressed,
            margin: margin,
            child: _buildChild(),
          );
  }

  Widget _buildChild() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leading ?? 0.hBox(),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title ?? 0.vBox(),
            subTitle ?? 0.vBox(),
          ],
        ),
        const Spacer(),
        trailing ?? 0.hBox(),
      ],
    );
  }
}

class SwitchableListTile extends StatelessWidget {
  const SwitchableListTile({
    super.key,
    required this.value,
    this.enabled = true,
    this.onPressed,
    this.outlined,
    this.leading,
    this.title,
    this.subTitle,
  });

  final bool value;
  final bool enabled;
  final bool? outlined;
  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
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
