import 'dart:ui';

import 'package:flutter/material.dart';

class BlurryBackground extends StatelessWidget {
  final Widget child;
  final double? sigmaX, sigmaY;

  const BlurryBackground(
      {required this.child, super.key, this.sigmaX, this.sigmaY});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX ?? 1.8, sigmaY: sigmaX ?? 1.8),
      child: child,
    );
  }
}
