import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/stateful_text.dart';

class SelectableAppTile extends ConsumerWidget {
  const SelectableAppTile({
    super.key,
    required this.isSelected,
    required this.appPackage,
    required this.onSelect,
    required this.onDeselect,
  });

  final String appPackage;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onDeselect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final app =
        ref.watch(appsProvider.select((value) => value.value?[appPackage]));
    if (app == null) return 0.vBox();

    return RoundedContainer(
      key: Key(appPackage),
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      onPressed: app.isImpSysApp
          ? null
          : isSelected
              ? onDeselect
              : onSelect,
      child: ListTileSkeleton(
        /// App icon
        leading: ApplicationIcon(
          app: app,
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
