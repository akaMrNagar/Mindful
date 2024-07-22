import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverTabsBottomPadding extends StatelessWidget {
  const SliverTabsBottomPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        128.vSliverBox,
        const Center(
          child: StyledText(
            "Made with ♥️ in 🇮🇳",
            fontSize: 14,
          ),
        ),
        128.vSliverBox,
      ],
    );
  }
}
