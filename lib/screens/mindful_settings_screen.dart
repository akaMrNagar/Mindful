import 'package:flutter/material.dart';
import 'package:mindful/widgets/shared/widgets_revealer.dart';

class MindfulSettingsScreen extends StatelessWidget {
  const MindfulSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            WidgetsRevealer(children: []),
          ],
        ),
      ),
    );
  }
}
