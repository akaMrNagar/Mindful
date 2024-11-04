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
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverShimmerList extends StatelessWidget {
  /// Placeholder shimmer list while the data is loading
  const SliverShimmerList({
    super.key,
    this.includeSubtitle = false,
  });

  final bool includeSubtitle;

  @override
  Widget build(BuildContext context) {
    return SliverSkeletonizer.zone(
      enabled: true,
      child: SliverList.builder(
        itemCount: 20,
        itemBuilder: (_, i) => DefaultListTile(
          leading: const Bone.circle(size: 36),
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
