import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';

class ListTileSkeleton extends StatelessWidget {
  const ListTileSkeleton({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leading ?? 0.hBox(),
        if (leading != null) const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title ?? 0.vBox(),
              subtitle ?? 0.vBox(),
            ],
          ),
        ),
        trailing ?? 0.hBox(),
      ],
    );
  }
}
