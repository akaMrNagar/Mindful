/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/models/usage_filter_model.dart';
import 'package:mindful/ui/common/search_bar.dart';

class SearchFilterPanel extends StatelessWidget {
  const SearchFilterPanel({
    super.key,
    required this.filter,
    required this.isSelectedAll,
    required this.onFilterChanged,
    required this.onToggleSelectAll,
  });

  final UsageFilterModel filter;
  final ValueChanged<UsageFilterModel> onFilterChanged;

  final bool isSelectedAll;

  /// Callback with param `TRUE` to select all and  'FALSE' to deselect all
  final ValueChanged<bool> onToggleSelectAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Search bar
        Expanded(
          child: DefaultSearchBar(
            hintText: context.locale.search_apps_hint,
            onSubmitted: (value) => onFilterChanged(
              filter.copyWith(query: value),
            ),
          ),
        ),

        /// Select/Deselect all
        IconButton.filledTonal(
          onPressed: () => onToggleSelectAll(!isSelectedAll),
          icon: Icon(
            isSelectedAll
                ? FluentIcons.select_all_on_20_regular
                : FluentIcons.select_all_off_20_regular,
          ),
        ),

        /// Sort by screen time, network usage, alphabetically
        IconButton.filledTonal(
          icon: Icon(
            [
              FluentIcons.phone_screen_time_20_regular,
              FluentIcons.earth_20_regular,
              FluentIcons.text_case_lowercase_20_regular,
            ][filter.usageType.index],
            size: 20,
          ),
          onPressed: () => onFilterChanged(
            filter.copyWith(
              usageType: UsageType.values[
                  (filter.usageType.index + 1) % UsageType.values.length],
            ),
          ),
        ),

        /// Ascending - Descending
        IconButton.filledTonal(
          icon: Icon(
            filter.reverse
                ? FluentIcons.arrow_up_20_regular
                : FluentIcons.arrow_down_20_regular,
            size: 20,
          ),
          onPressed: () => onFilterChanged(
            filter.copyWith(reverse: !filter.reverse),
          ),
        ),
      ],
    );
  }
}
