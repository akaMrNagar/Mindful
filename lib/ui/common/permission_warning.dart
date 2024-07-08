import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PermissionWarning extends StatelessWidget {
  const PermissionWarning({
    super.key,
    required this.havePermission,
    required this.title,
    required this.information,
    required this.onTapAllow,
  });

  final bool havePermission;
  final String title;
  final String information;
  final VoidCallback onTapAllow;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedPaintExtent(
      duration: 750.ms,
      curve: Curves.easeInOut,
      child: SliverFlexiblePinnedHeader(
        child: RoundedContainer(
          circularRadius: 24,
          color: Theme.of(context).colorScheme.primary,
          height: havePermission ? 0 : null,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  FluentIcons.alert_urgent_20_regular,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),

                2.vBox(),

                /// Warning title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),

                6.vBox(),

                /// Wraning info
                Text(
                  information,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),

                16.vBox(),

                /// Start accessiblity button
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: onTapAllow,
                    child: const Text("Allow"),
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
