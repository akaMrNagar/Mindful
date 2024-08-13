import 'package:flutter/material.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';

class TabTimeline extends StatelessWidget {
  const TabTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        SliverFlexibleAppBar(title: "Timeline"),
      ],
    );
  }
}
