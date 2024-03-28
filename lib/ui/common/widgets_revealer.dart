import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The main widget responsible for animation when user switches the screen
/// It animates childrens with delay based on index
class WidgetsRevealer extends ConsumerStatefulWidget {
  const WidgetsRevealer({
    super.key,
    required this.children,
    this.baseDelay = 500,
    this.childDelay = 50,
    this.animDuration = 250,
    this.reAnimate = false,
    this.keepStateAlive = false,
    this.onInit,
    this.onInitDelayed,
    this.itemExtent,
  });

  final int baseDelay;
  final int childDelay;
  final int animDuration;
  final bool reAnimate;
  final bool keepStateAlive;
  final List<Widget> children;
  final double? itemExtent;
  final Function(WidgetRef ref)? onInit;
  final Function(WidgetRef ref)? onInitDelayed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WidgetListAnimatorState();
}

class _WidgetListAnimatorState extends ConsumerState<WidgetsRevealer>
    with AutomaticKeepAliveClientMixin {
  bool _waiting = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      widget.onInit?.call(ref);
      await Future.delayed(widget.baseDelay.ms);
      widget.onInitDelayed?.call(ref);

      if (mounted) {
        setState(() {
          _waiting = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _waiting
        ? const SizedBox()
        : ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemExtent: widget.itemExtent,
            padding: EdgeInsets.zero,
            itemCount: widget.children.length,
            itemBuilder: (context, index) {
              return widget.children[index]
                  .animate(delay: (index * widget.childDelay).ms)
                  .fadeIn(duration: widget.animDuration.ms)
                  .moveY(
                    begin: 100,
                    end: 0,
                    // duration: dur.ms,
                    curve: Curves.easeOutBack,
                  );
            },
          );
  }

  void _reAnimate() async {
    if (mounted) {
      setState(() {
        _waiting = true;
      });
    }
    await Future.delayed(const Duration(milliseconds: 50));
    if (mounted) {
      setState(() {
        _waiting = false;
      });
    }
  }

  @override
  void didUpdateWidget(covariant WidgetsRevealer oldWidget) {
    if (mounted &&
        widget.reAnimate &&
        !_waiting &&
        !listEquals(widget.children, oldWidget.children)) {
      _reAnimate();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepStateAlive;
}
