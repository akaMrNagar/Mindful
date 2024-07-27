import 'package:flutter/material.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverFlexibleAppBar extends StatelessWidget {
  /// Pre-configured default app bar used globally
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
            child: StyledText(
              title,
              maxLines: 1,
              fontSize: 32,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ),
    );
  }
}
