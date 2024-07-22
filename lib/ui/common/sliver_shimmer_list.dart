import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverShimmerList extends StatelessWidget {
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
          height: 64,
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
