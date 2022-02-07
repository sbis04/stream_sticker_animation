import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimatedSticker extends StatelessWidget {
  const AnimatedSticker({
    Key? key,
    required this.artboard,
  }) : super(key: key);

  final String artboard;

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/stream_animation.riv',
      artboard: artboard,
      animations: const ['stream'],
    );
  }
}