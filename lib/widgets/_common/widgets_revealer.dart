import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetsRevealer extends ConsumerStatefulWidget {
  const WidgetsRevealer({
    super.key,
    required this.children,
    this.baseDelay = 500,
    this.childDelay = 50,
    this.animDuration = 250,
    this.onInit,
    this.onInitDelayed,
  });

  final int baseDelay;
  final int childDelay;
  final int animDuration;
  final List<Widget> children;
  final Function(WidgetRef ref)? onInit;
  final Function(WidgetRef ref)? onInitDelayed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WidgetListAnimatorState();
}

class _WidgetListAnimatorState extends ConsumerState<WidgetsRevealer> {
  bool waiting = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      widget.onInit?.call(ref);
      await Future.delayed(widget.baseDelay.ms);
      widget.onInitDelayed?.call(ref);

      if (mounted) {
        setState(() {
          waiting = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return waiting
        ? const SizedBox()
        : ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: widget.children.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return RepaintBoundary(
                child: widget.children[index]
                    .animate(delay: (index * widget.childDelay).ms)
                    .fadeIn()
                    .moveY(
                      begin: 100,
                      end: 0,
                      duration: widget.animDuration.ms,
                      curve: Curves.easeOutBack,
                    ),
              );
            },
          );
  }
}
