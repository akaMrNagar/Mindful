import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/ui/common/default_list_tile.dart';

class DeviceDndTile extends StatelessWidget {
  const DeviceDndTile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultListTile(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      leading: const Icon(FluentIcons.alert_20_regular),
      titleText: "Do not disturb settings",
      subtitleText: "Manage which apps and notifications can reach you in DND.",
      trailing: const Icon(FluentIcons.chevron_right_20_filled),
      onPressed: () => MethodChannelService.instance.openDeviceDndSettings(),
    );
  }
}
