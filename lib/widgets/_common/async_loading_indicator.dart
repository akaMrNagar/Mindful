import 'package:flutter/material.dart';

class AsyncLoadingIndicator extends StatelessWidget {
  const AsyncLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RepaintBoundary(child: CircularProgressIndicator()),
    );
  }
}
