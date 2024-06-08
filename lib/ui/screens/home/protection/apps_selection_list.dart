import 'package:flutter/material.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/selectable_app_tile.dart';

class AppsSelectionList extends StatelessWidget {
  const AppsSelectionList({
    super.key,
    required this.selectedApps,
    required this.onSelect,
    required this.onDeselect,
    this.showHeader = true,
  });

  final bool showHeader;
  final List<String> selectedApps;
  final void Function(String package) onSelect;
  final void Function(String package) onDeselect;

  @override
  Widget build(BuildContext context) {
    return AnimatedAppsList(
      itemExtent: 56,
      showHeader: showHeader,
      selectedDoW: dayOfWeek,
      usageType: UsageType.networkUsage,
      sortApps: (apps) {
        return [
          ...apps.where((e) => selectedApps.contains(e)),
          if (selectedApps.isNotEmpty) ...[""],
          ...apps.where((e) => !selectedApps.contains(e)),
        ];
      },
      itemBuilder: (context, appPackage) => appPackage.isEmpty
          ? const Divider(indent: 12, endIndent: 12)
          : SelectableAppTile(
              appPackage: appPackage,
              isSelected: selectedApps.contains(appPackage),
              onSelect: () => onSelect(appPackage),
              onDeselect: () => onDeselect(appPackage),
            ),
    );
  }
}
