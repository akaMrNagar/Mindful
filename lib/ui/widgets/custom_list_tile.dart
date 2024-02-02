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

  final bool outlined;
  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return outlined
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
