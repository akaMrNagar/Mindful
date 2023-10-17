import 'package:flutter/material.dart';

/// Global loading widget for async providers.
class AsyncLoadingIndicator extends StatelessWidget {
  const AsyncLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RepaintBoundary(child: CircularProgressIndicator()),
    );
  }
}
