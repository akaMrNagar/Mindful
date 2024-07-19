import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';

class TabAbout extends ConsumerWidget {
  const TabAbout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.only(left: 4, right: 8),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          /// Appbar
          SliverFlexibleAppBar(title: "About"),

          /// About

          /// contribute and donate

          /// Privacy police

          /// Permissions

          /// Open source license
        ],
      ),
    );
  }
}
