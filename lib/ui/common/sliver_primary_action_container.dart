import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverPrimaryActionContainer extends StatelessWidget {
  /// [RoundedContainer] with primary accent and a CTA button
  const SliverPrimaryActionContainer({
    super.key,
    required this.isVisible,
    required this.title,
    required this.information,
    this.icon,
    this.onTapAction,
    this.actionBtnLabel,
    this.actionBtnIcon,
    this.helpUrl,
    this.margin = EdgeInsets.zero,
  });

  final bool isVisible;
  final String title;
  final String information;
  final EdgeInsets margin;
  final IconData? icon;
  final String? actionBtnLabel;
  final String? helpUrl;
  final VoidCallback? onTapAction;
  final Widget? actionBtnIcon;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedPaintExtent(
      duration: 500.ms,
      curve: Curves.easeOutExpo,
      child: SliverVisibility(
        visible: isVisible,
        sliver: RoundedContainer(
          circularRadius: 24,
          padding: const EdgeInsets.all(16),
          margin: margin,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon ?? FluentIcons.alert_urgent_20_regular),

                6.vBox,

                /// Warning title
                StyledText(
                  title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),

                2.vBox,

                /// Warning info
                StyledText(
                  information,
                  fontSize: 12,
                ),

                12.vBox,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// Help button
                    if (helpUrl != null)
                      TextButton(
                        onPressed: () =>
                            MethodChannelService.instance.launchUrl(helpUrl!),
                        child: const Text("Help?"),
                      ),

                    0.hBox,

                    /// Allow permission button
                    if (onTapAction != null)
                      FilledButton.icon(
                        onPressed: onTapAction,
                        label: Text(actionBtnLabel ?? "Allow"),
                        icon: actionBtnIcon,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ).sliver,
      ),
    );
  }
}
