import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/widgets/shared/app_bar.dart';

class FocusProfilesScreen extends ConsumerWidget {
  const FocusProfilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const MindfulAppBar(title: "Focus profiles"),
          SliverList.list(children: const []),
        ],
      ),
    );
  }
}
