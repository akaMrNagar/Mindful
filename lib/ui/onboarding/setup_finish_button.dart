import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/permissions/alarm_permission.dart';
import 'package:mindful/ui/permissions/display_overlay_permission.dart';
import 'package:mindful/ui/permissions/usage_access_permission.dart';

class SetupFinishButton extends StatelessWidget {
  const SetupFinishButton({
    super.key,
    required this.haveAllEssentialPermissions,
  });

  final bool haveAllEssentialPermissions;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 48,
      width: 196,
      color: Theme.of(context).colorScheme.primary,
      onPressed: () => haveAllEssentialPermissions
          ? _finishSetup(context)
          : _showPermissionsSheet(context),
      child: StyledText(
        haveAllEssentialPermissions ? "Let's Go" : "Grant Permissions",
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ).animate().fadeIn(duration: 750.ms);
  }

  void _finishSetup(BuildContext context) {
    MethodChannelService.instance.setOnboardingDone();
    Navigator.of(context).maybePop();
  }

  void _showPermissionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: BottomSheet(
          enableDrag: false,
          onClosing: () {},
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                12.vBox,
                // Handle
                RoundedContainer(
                  height: 8,
                  width: 64,
                  color: Theme.of(context).disabledColor,
                ).centered,
                8.vBox,

                /// Title
                StyledText(
                  "Grant essential permissions",
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                6.vBox,

                /// Info
                const StyledText(
                  "To ensure Mindful works effectively and supports your focus, please grant the essential permissions.\n\nThank you",
                ),
                6.vBox,

                /// Permissions
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      12.vSliverBox,
                      const UsageAccessPermission(showEvenIfGranted: true),
                      const DisplayOverlayPermission(showEvenIfGranted: true),
                      const ExactAlarmPermission(showEvenIfGranted: true),
                      96.vSliverBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
