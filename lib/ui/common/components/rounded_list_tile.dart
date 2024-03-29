import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/components/rounded_container.dart';

class RoundedListTile extends StatelessWidget {
  const RoundedListTile({
    super.key,
    this.leading,
    this.title,
    this.subTitle,
    this.trailing,
    this.onPressed,
    this.height,
    this.color,
    this.borderColor,
    this.padding,
    this.applyBorder = true,
    this.bottomGap = 4,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final EdgeInsets? padding;
  final bool applyBorder;
  final double bottomGap;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: color,
      borderColor: borderColor,
      height: height,
      applyBorder: applyBorder,
      onPressed: onPressed,
      margin: EdgeInsets.only(bottom: bottomGap),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leading ?? 0.hBox(),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title ?? 0.vBox(),

              /// FIXME: Overflow issue
              subTitle ?? 0.vBox(),
            ],
          ),
          const Spacer(),
          trailing ?? 0.hBox(),
        ],
      ),
    );
  }
}
