import 'package:flutter/material.dart';
import 'dart:async';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final double offsetFinal;
  const DelayedAnimation(
      {required this.child, required this.delay, required this.offsetFinal});

  @override
  State<DelayedAnimation> createState() => _DelaydsAnimationState();
}

class _DelaydsAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    final curve =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    _animOffset =
        Tween<Offset>(begin: Offset(0.0, widget.offsetFinal), end: Offset.zero)
            .animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
