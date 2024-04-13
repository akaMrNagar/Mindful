import 'package:flutter/material.dart';

class SliverFlexibleAppBar extends StatelessWidget {
  const SliverFlexibleAppBar({
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
        collapseMode: CollapseMode.pin,
        background: SingleChildScrollView(
          reverse: true,
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              title,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
