import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrimaryUsageCard extends StatelessWidget {
  const PrimaryUsageCard({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
  });

  final IconData icon;
  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 128,
      applyBorder: true,
      circularRadius: 24,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(children: [Icon(icon)]),
          StyledText(
            title,
            height: 1,
            fontSize: 14,
          ),
          4.vBox,
          Skeleton.leaf(
            child: StyledText(
              info,
              height: 1,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
