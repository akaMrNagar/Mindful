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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/filter_model.dart';
import 'package:mindful/providers/packages_by_filter_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/search_filter_panel.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverDistractingAppsList extends ConsumerStatefulWidget {
  const SliverDistractingAppsList({
    super.key,
    required this.distractingApps,
    required this.onSelectionChanged,
    this.hiddenApps = const [],
  });

  final List<String> distractingApps;
  final List<String> hiddenApps;
  final Function(String package, bool isSelected) onSelectionChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SliverDistractingAppsListState();
}

class _SliverDistractingAppsListState
    extends ConsumerState<SliverDistractingAppsList> {
  FilterModel _filter = FilterModel(selectedDayOfWeek: todayOfWeek);

  _onFilterChanged(FilterModel filter) {
    if (!mounted) return;
    setState(() => _filter = filter);
  }

  @override
  Widget build(BuildContext context) {
    final allApps = ref.watch(packagesByFilterProvider(_filter));

    /// Selected apps which are installed
    final selectedApps =
        allApps.value?.where((e) => widget.distractingApps.contains(e)) ?? [];

    /// Unselected apps which are installed
    final unselectedApps = (allApps.value ?? []).where(
      (e) =>
          !widget.distractingApps.contains(e) && !widget.hiddenApps.contains(e),
    );

    return MultiSliver(
      children: [
        ContentSectionHeader(
          title: widget.distractingApps.isEmpty
              ? context.locale.select_distracting_apps_heading
              : context.locale.your_distracting_apps_heading,
        ).sliver,

        /// Search and filter panel
        SearchFilterPanel(
          filter: _filter,
          onFilterChanged: _onFilterChanged,
        ).sliver,

        18.vSliverBox,

        /// Apps list
        SliverAnimatedSwitcher(
          duration: AppConstants.defaultAnimDuration,
          switchInCurve: AppConstants.defaultCurve,
          switchOutCurve: AppConstants.defaultCurve.flipped,
          child: allApps.hasValue
              ? AnimatedAppsList(
                  itemExtent: 56,
                  separatorTitle: context.locale.select_more_apps_heading,
                  appPackages: [
                    ...selectedApps,

                    /// Will act as a separator
                    if (widget.distractingApps.isNotEmpty) ...[""],

                    ...unselectedApps,
                  ],
                  // ].where((e) => e.contains("utu")).toList(), // For searching
                  itemBuilder: (context, app, _) {
                    final isSelected =
                        widget.distractingApps.contains(app.packageName);
                    return DefaultListTile(
                      isSelected: app.isImpSysApp ? null : isSelected,
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
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

                        widget.onSelectionChanged(app.packageName, !isSelected);
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
