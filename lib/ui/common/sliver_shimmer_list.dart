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
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverShimmerList extends StatelessWidget {
  /// Placeholder shimmer list while the data is loading
  const SliverShimmerList({
    super.key,
    this.includeLeading = true,
    this.includeSubtitle = false,
    this.includeTrailing = false,
  });

  final bool includeLeading;
  final bool includeSubtitle;
  final bool includeTrailing;

  @override
  Widget build(BuildContext context) {
    const itemCount = 20;

    return SliverSkeletonizer.zone(
      enabled: true,
      child: SliverList.builder(
        itemCount: itemCount,
        itemBuilder: (_, i) => DefaultListTile(
          position: getItemPositionInList(i, itemCount),
          leading: includeLeading ? const Bone.iconButton() : null,
          trailing: includeTrailing ? const Bone.icon() : null,
          title: Bone.text(
            width: 120.randomHalf.toDouble(),
            fontSize: 16,
          ),
          subtitle: includeSubtitle
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Bone.text(
                    fontSize: 12,
                    width: 208.randomHalf.toDouble(),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
