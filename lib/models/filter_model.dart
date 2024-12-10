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
import 'package:mindful/core/enums/sorting_type.dart';

@immutable
class FilterModel {
  final String query;
  final int selectedDayOfWeek;
  final bool reverse;
  final bool includeAll;
  final SortingType sorting;

  const FilterModel({
    this.query = "",
    this.reverse = false,
    this.includeAll = true,
    this.sorting = SortingType.screen,
    required this.selectedDayOfWeek,
  });

  FilterModel copyWith({
    String? query,
    int? selectedDayOfWeek,
    bool? reverse,
    bool? includeAll,
    SortingType? sorting,
  }) {
    return FilterModel(
      query: query ?? this.query,
      selectedDayOfWeek: selectedDayOfWeek ?? this.selectedDayOfWeek,
      reverse: reverse ?? this.reverse,
      includeAll: includeAll ?? this.includeAll,
      sorting: sorting ?? this.sorting,
    );
  }
}
