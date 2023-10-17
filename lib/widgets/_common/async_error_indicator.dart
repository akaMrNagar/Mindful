import 'package:flutter/material.dart';


/// Global error widget for async providers
class AsyncErrorIndicator extends StatelessWidget {
  const AsyncErrorIndicator(
    this.error,
    this.stackTrace, {
    super.key,
  });

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          error.toString(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
        ),
        Text(
          stackTrace.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
