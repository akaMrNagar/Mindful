import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/permissions/alarm_permission.dart';
import 'package:mindful/ui/permissions/display_overlay_permission.dart';
import 'package:mindful/ui/permissions/notification_permission.dart';
import 'package:mindful/ui/permissions/usage_access_permission.dart';

class SetupFinishButton extends ConsumerStatefulWidget {
  const SetupFinishButton({
    super.key,
    required this.haveAllEssentialPermissions,
  });

  final bool haveAllEssentialPermissions;

  @override
  SetupFinishButtonState createState() => SetupFinishButtonState();
}

class SetupFinishButtonState extends ConsumerState<SetupFinishButton> {
  bool _isSheetOpen = false;
  BuildContext? _sheetContext;

  @override
  void didUpdateWidget(covariant SetupFinishButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if permissions are now all granted
    if (widget.haveAllEssentialPermissions &&
        _isSheetOpen &&
        _sheetContext != null) {
      Navigator.of(_sheetContext!).pop(); // Close the bottom sheet
      _isSheetOpen = false;
      _sheetContext = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 48,
      width: 196,
      color: Theme.of(context).colorScheme.primary,
      onPressed: () => widget.haveAllEssentialPermissions
          ? _finishSetup(context, ref)
          : _showPermissionsSheet(context),
      child: StyledText(
        widget.haveAllEssentialPermissions ? "Let's Go" : "Grant Permissions",
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ).animate().fadeIn(duration: 300.ms).scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
        );
  }

  void _finishSetup(BuildContext context, WidgetRef ref) {
    ref.read(appsProvider.notifier).refreshDeviceApps();
    MethodChannelService.instance.setOnboardingDone();
    Navigator.of(context).maybePop();
  }

  void _showPermissionsSheet(BuildContext context) {
    _isSheetOpen = true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        _sheetContext = context;
        return SizedBox(
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
                        const NotificationPermission(),
                        const ExactAlarmPermission(),
                        const UsageAccessPermission(),
                        const DisplayOverlayPermission(),
                        96.vSliverBox,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(
      () {
        _isSheetOpen = false;
        _sheetContext = null;
      },
    );
  }
}
