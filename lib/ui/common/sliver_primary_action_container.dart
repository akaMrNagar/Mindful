import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverPrimaryActionContainer extends StatelessWidget {
  const SliverPrimaryActionContainer({
    super.key,
    required this.isVisible,
    required this.title,
    required this.information,
    this.onTapAction,
    this.actionBtnLabel,
    this.actionBtnIcon,
    this.margin = EdgeInsets.zero,
  });

  final bool isVisible;
  final String title;
  final String information;
  final EdgeInsets margin;
  final String? actionBtnLabel;
  final VoidCallback? onTapAction;
  final Widget? actionBtnIcon;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedPaintExtent(
      duration: 500.ms,
      curve: Curves.easeOutExpo,
      child: Visibility(
        visible: isVisible,
        child: RoundedContainer(
          circularRadius: 24,
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.all(16),
          margin: margin,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  FluentIcons.alert_urgent_20_regular,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),

                2.vBox,

                /// Warning title
                StyledText(
                  title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),

                6.vBox,

                /// Warning info
                StyledText(
                  information,
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),

                16.vBox,

                /// Allow permission button
                if (onTapAction != null)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      onPressed: onTapAction,
                      label: Text(actionBtnLabel ?? "Allow"),
                      icon: actionBtnIcon,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ).sliver,
    );
  }
}
