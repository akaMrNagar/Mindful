import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/services/method_channel_service.dart';

@immutable
class ChangeLog {
  final IconData icon;
  final String label;
  final List<String> bulletPoints;
  final void Function(BuildContext context)? onTap;

  const ChangeLog({
    required this.icon,
    required this.label,
    this.onTap,
    this.bulletPoints = const [],
  });
}

class ChangeLogsData {
  /// Returns a formatted list with version headers and their respective logs
  List<dynamic> getFormattedChangeLogs() {
    List<dynamic> formattedList = [];
    _allChangeLogs.forEach(
      (version, logs) {
        formattedList.add(version);
        formattedList.addAll(logs);
      },
    );
    return formattedList;
  }

  /// Map of all app versions and the list of[ChangeLog]
  late final Map<String, List<ChangeLog>> _allChangeLogs = {
    MethodChannelService.instance.deviceInfo.mindfulVersion: _latest,
    "v1.2.8": _v1_2_8,
    "v1.2.4": _v1_2_4,
    "v1.2.0": _v1_2_0,
  };

  /// Change logs for this latest version
  final List<ChangeLog> _latest = [
    ChangeLog(
      icon: FluentIcons.target_arrow_20_filled,
      label: "Quick Focus Tile",
      onTap: (ctx) async {
        final isSuccess =
            await MethodChannelService.instance.promptForQuickTile();

        if (!ctx.mounted) return;

        ctx.showSnackAlert(
          isSuccess
              ? "Quick tile added successfully."
              : "Tile is already added or something went wrong!",
          icon: FluentIcons.target_arrow_20_filled,
        );
      },
      bulletPoints: const [
        "One tap to focus mode.",
        "Directly open focus mode.",
        "Use pre-configured profiles."
      ],
    ),
    const ChangeLog(
      icon: FluentIcons.open_20_filled,
      label: "App shortcuts",
      bulletPoints: [
        "One tap to Parental Controls.",
        "One tap to Batched Notifications.",
        "One tap to Focus Mode.",
        "Automate with third party apps.",
        "Press and hold app icon for options."
      ],
    ),
    const ChangeLog(
      icon: FluentIcons.app_title_20_filled,
      label: "Mindful overlay",
      bulletPoints: [
        "New app paused overlay with more info.",
        "Clearly see why an app is blocked.",
        "Check how much time you have left for an app.",
        "Use emergency for urgent situation.",
        "More reminder options.",
      ],
    ),
    ChangeLog(
      icon: FluentIcons.shield_keyhole_20_filled,
      label: "Parental controls",
      onTap: (context) =>
          Navigator.of(context).pushNamed(AppRoutes.parentalControlsPath),
      bulletPoints: const [
        "Invincible mode for distractions.",
        "Tamper protection for sneaky workarounds.",
        "Biometric lock for added security.",
      ],
    ),
    ChangeLog(
      icon: FluentIcons.earth_20_filled,
      label: "Websites blocker",
      onTap: (context) =>
          Navigator.of(context).pushNamed(AppRoutes.websitesBlockingPath),
      bulletPoints: const [
        "Mark custom websites as NSFW.",
        "NSFW websites can't be removed once added.",
      ],
    ),
  ];

  /// Change logs for v1.2.8
  final List<ChangeLog> _v1_2_8 = [
    const ChangeLog(
      icon: FluentIcons.alert_snooze_20_filled,
      label: "Notification batching",
      bulletPoints: [
        "Batch notifications from different apps.",
        "Schedule them for later.",
        "Stay focused without missing anything important.",
      ],
    ),
    const ChangeLog(
      icon: FluentIcons.box_multiple_20_filled,
      label: "Notification grouping",
      bulletPoints: [
        "Organizes notifications by app for easy browsing.",
        "Groups messages from the same conversation together.",
      ],
    ),
  ];

  /// Change logs for v1.2.4
  final List<ChangeLog> _v1_2_4 = [
    const ChangeLog(
      icon: FluentIcons.prohibited_20_filled,
      label: "App restrictions",
      bulletPoints: [
        "New app launch count limit.",
        "New active period limit.",
      ],
    ),
    ChangeLog(
      icon: FluentIcons.prohibited_multiple_20_filled,
      label: "Group restrictions",
      onTap: (context) =>
          Navigator.of(context).pushNamed(AppRoutes.restrictionGroupsPath),
      bulletPoints: const [
        "Add restrictions to group of apps.",
        "Combined time limit.",
        "Combined active period limit.",
      ],
    ),
    const ChangeLog(
      icon: FluentIcons.data_pie_20_filled,
      label: "Usage exclusion",
      bulletPoints: [
        "Exclude apps from total screen usage.",
      ],
    ),
  ];

  /// Change logs for v1.2.0
  final List<ChangeLog> _v1_2_0 = [
    const ChangeLog(
      icon: FluentIcons.prohibited_20_filled,
      label: "App restrictions",
      bulletPoints: [
        "Set timer for apps",
        "Restrict app from accessing internet.",
      ],
    ),
    const ChangeLog(
      icon: FluentIcons.brain_20_filled,
      label: "Wellbeing",
      bulletPoints: [
        "Block short content on multiple platforms",
        "Block adult websites.",
        "Block custom websites.",
      ],
    ),
    const ChangeLog(
      icon: FluentIcons.sleep_20_filled,
      label: "Bedtime",
      bulletPoints: [
        "Set daily bedtime routine.",
        "Block distracting apps at bedtime.",
        "Apply routine to selected days of week.",
      ],
    ),
  ];
}
