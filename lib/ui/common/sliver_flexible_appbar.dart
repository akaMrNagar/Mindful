import 'package:flutter/material.dart';

class SliverFlexibleAppBar extends StatelessWidget {
  const SliverFlexibleAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0,
      expandedHeight: 96,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
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
