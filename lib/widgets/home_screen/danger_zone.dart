import 'package:flutter/material.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';

class DangerZone extends StatelessWidget {
  const DangerZone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const FocusModes(),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            "You can uninstall Mindful only when no app timers are running in strict mode",
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.color
                  ?.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 32),
        InteractiveCard(
          onPressed: () {},
          margin: const EdgeInsets.symmetric(horizontal: 32),
          // color: Colors.red.withOpacity(0.1),
          child: Text(
            "Uninstall",
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.color
                  ?.withOpacity(0.2),
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        )
      ],
    );
  }
}
