import 'package:flutter/material.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/stateful_text.dart';

class CheckboxAppTile extends StatelessWidget {
  const CheckboxAppTile({
    super.key,
    required this.app,
    required this.isSelected,
    required this.onSelectionChanged,
  });

  final AndroidApp app;
  final bool isSelected;
  final ValueChanged<bool> onSelectionChanged;

  void _informAboutImpApps() async {
    await MethodChannelService.instance
        .showToast("Can't select important apps");
  }

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: isSelected ? Colors.red.withOpacity(0.1) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: const EdgeInsets.only(bottom: 2),
      onPressed: app.isImpSysApp
          ? _informAboutImpApps
          : () => onSelectionChanged(!isSelected),
      child: ListTileSkeleton(
        /// App icon
        leading: ApplicationIcon(
          app: app,
          isGreyedOut: isSelected,
          size: 16,
        ),

        /// App Name
        title: StatefulText(
          app.name,
          fontSize: 16,
        ),

        /// checkbox
        trailing: app.isImpSysApp
            ? null
            : IgnorePointer(
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) {},
                ),
              ),
      ),
    );
  }
}
