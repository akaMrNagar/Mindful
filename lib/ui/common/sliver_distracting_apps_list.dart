/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/packages_by_screen_usage_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverDistractingAppsList extends ConsumerWidget {
  const SliverDistractingAppsList({
    super.key,
    required this.distractingApps,
    required this.onSelectionChanged,
  });

  final List<String> distractingApps;
  final Function(String package, bool isSelected) onSelectionChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Arguments for family provider
    final args = (selectedDoW: todayOfWeek, includeAll: true);
    final allApps = ref.watch(packagesByScreenUsageProvider(args));

    /// Selected apps which are installed
    final selectedApps =
        distractingApps.where((e) => allApps.value!.contains(e));

    /// Unselected apps which are installed
    final unselectedApps =
        allApps.value!.where((e) => !distractingApps.contains(e));

    return MultiSliver(
      children: [
        ContentSectionHeader(
          title: distractingApps.isEmpty
              ? context.locale.select_distracting_apps_heading
              : context.locale.your_distracting_apps_heading,
        ).sliver,

        /// Apps list
        SliverAnimatedSwitcher(
          duration: 300.ms,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: allApps.hasValue
              ? AnimatedAppsList(
                  itemExtent: 56,
                  separatorTitle: context.locale.select_more_apps_heading,
                  appPackages: [
                    ...selectedApps,

                    /// Will act as a separator
                    if (distractingApps.isNotEmpty) ...[""],

                    ...unselectedApps,
                  ],
                  itemBuilder: (context, app, _) {
                    final isSelected =
                        distractingApps.contains(app.packageName);
                    return DefaultListTile(
                      isSelected: app.isImpSysApp ? null : isSelected,
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainer
                          .withOpacity(0.5),
                      position: _resolvePosition(
                        app.packageName,
                        selectedApps,
                        unselectedApps,
                      ),
                      leading: ApplicationIcon(app: app, size: 16),
                      titleText: app.name,
                      onPressed: () {
                        /// If app is important system app
                        if (app.isImpSysApp) {
                          context.showSnackAlert(
                            context.locale.imp_distracting_apps_snack_alert,
                          );
                          return;
                        }

                        onSelectionChanged(app.packageName, !isSelected);
                      },
                    );
                  },
                )
              : const SliverShimmerList(),
        ),
      ],
    );
  }

  ItemPosition _resolvePosition(
    String package,
    Iterable<String> selected,
    Iterable<String> unselected,
  ) =>
      (selected.length == 1 && selected.first == package) ||
              (unselected.length == 1 && unselected.first == package)
          ? ItemPosition.none
          : (selected.isNotEmpty && selected.first == package) ||
                  (unselected.isNotEmpty && unselected.first == package)
              ? ItemPosition.start
              : (selected.isNotEmpty && selected.last == package) ||
                      (unselected.isNotEmpty && unselected.last == package)
                  ? ItemPosition.end
                  : ItemPosition.mid;
}
