import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/utils/tags.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/focus_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/time_text_short.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';

/// List tile used for displaying app usage info based on the bool [selectedUsageType]
class ApplicationTile extends ConsumerWidget {
  const ApplicationTile({
    super.key,
    required this.app,
    required this.selectedUsageType,
    required this.selectedDoW,
  });

  final AndroidApp app;
  final UsageType selectedUsageType;
  final int selectedDoW;

  void _pickAppTimer(
    BuildContext context,
    WidgetRef ref,
    int prevTimer,
    int screenTime,
  ) async {
    final isInvincibleModeOn = ref.read(
      settingsProvider.select((v) => v.isInvincibleModeOn),
    );

    if (isInvincibleModeOn && prevTimer > 0 && screenTime >= prevTimer) {
      context.showSnackWarning(
        "Due to invincible mode, modifications to paused app's timer is not allowed.",
      );
      return;
    }

    final newTimer = await showAppTimerPicker(
      app: app,
      heroTag: AppTags.applicationTileTag(app.packageName),
      context: context,
      initialTime: prevTimer,
    );

    if (newTimer == prevTimer) return;
    ref.read(focusProvider.notifier).updateAppTimer(app.packageName, newTimer);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Watch timer for the package
    final appTimer = ref.watch(focusProvider
            .select((value) => value[app.packageName]?.timerSec)) ??
        0;


    return DefaultHero(
      tag: AppTags.applicationTileTag(app.packageName),
      child: DefaultListTile(
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.appDashboardScreen,
            arguments: (
              app: app,
              selectedUsageType: selectedUsageType,
              selectedDoW: selectedDoW,
            ),
          );
        },

        /// App icon
        leading: ApplicationIcon(app: app),

        /// App Name
        titleText: app.name,

        /// App's Screen Time OR Data Usage
        subtitle: StyledText(
          selectedUsageType == UsageType.networkUsage
              ? app.networkUsageThisWeek[selectedDoW].toData()
              : app.screenTimeThisWeek[selectedDoW].seconds.toTimeFull(),
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),

        /// Timer picker button
        trailing: app.isImpSysApp
            ? null
            : IconButton(
                icon: appTimer > 0
                    ? TimeTextShort(timeDuration: appTimer.seconds)
                    : const Icon(FluentIcons.timer_20_regular),
                onPressed: () => _pickAppTimer(
                  context,
                  ref,
                  appTimer,
                  app.screenTimeThisWeek[dayOfWeek],
                ),
              ),
      ),
    );
  }
}
