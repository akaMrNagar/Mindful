import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/ui/common/rounded_container.dart';

class BreathingWidget extends StatelessWidget {
  /// Puts the child widget on top of breathing animating containers in a stack
  const BreathingWidget({
    super.key,
    this.duration = const Duration(milliseconds: 3000),
    this.layers = 6,
    this.dimension = 296,
    this.circularRadius = 296,
    this.curve = Curves.easeOut,
    this.animateChild = true,
    required this.child,
  });

  final double dimension;
  final double circularRadius;
  final Duration duration;
  final int layers;
  final Widget child;
  final Curve curve;
  final bool animateChild;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Background waves
          ...List.generate(
            layers,
            (_) => AspectRatio(
              aspectRatio: 1,
              child: RoundedContainer(
                height: dimension,
                width: dimension,
                circularRadius: circularRadius,
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.5),
              ),
            ),
          ).animate(
            onPlay: (controller) => controller.repeat(),
            interval: (duration.inMilliseconds ~/ layers).ms,
            effects: [
              ScaleEffect(
                duration: duration,
                begin: Offset.zero,
                end: const Offset(1, 1),
                curve: curve,
              ),
              FadeEffect(
                duration: (duration.inMilliseconds * 0.9).ms,
                begin: 1,
                end: 0,
                curve: curve,
              ),
            ],
          ),

          /// Child
          FittedBox(
            child: animateChild
                ? child.animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                    effects: [
                      ScaleEffect(
                        duration: duration,
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1, 1),
                        curve: curve,
                      ),
                      ShakeEffect(
                        duration: duration,
                        curve: curve,
                        hz: 0.5,
                      ),
                    ],
                  )
                : child,
          ),
        ],
      ),
    );
  }
}
