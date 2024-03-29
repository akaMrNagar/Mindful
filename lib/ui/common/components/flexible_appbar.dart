import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';

class FlexibleAppBar extends StatelessWidget {
  const FlexibleAppBar({
    super.key,
    required this.title,
    this.canCollapse = true,
  });

  final String title;
  final bool canCollapse;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      toolbarHeight: canCollapse ? 0 : 96,
      expandedHeight: 96,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            12.vBox(),
          ],
        ),
      ),
    );
  }
}
