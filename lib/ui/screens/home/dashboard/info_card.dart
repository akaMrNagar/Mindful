import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
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
      height: 140,
      applyBorder: true,
      circularRadius: 24,
      // color: Colors.transparent,
      // color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon),
          StyledText(
            title,
            fontSize: 14,
          ),
          const Row(children: []),
          2.vBox(),
          StyledText(
            info,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
