import 'dart:math';

import 'package:flutter/material.dart';

/// {@template m3_scale_transitino}
/// A transition that imitates the default behavior of snackbars in Material 3.
///
/// This is used as the default transition for [MaterialSnackbar]
/// {@endtemplate}
class Material3ScaleTransition extends StatelessWidget {
  /// {@macro m3_scale_transitino}
  const Material3ScaleTransition(
      {super.key, required this.child, required this.animation});

  final Widget child;
  final Animation<double> animation;

  static final Animatable<double> _fadeInTransition = CurveTween(
    curve: const Interval(0.0, 0.2),
  );
  static final Animatable<double> _scaleInTransition = Tween<double>(
    begin: 0.3,
    end: 1.00,
  ).chain(CurveTween(curve: standardEasing));

  @override
  Widget build(BuildContext context) {
    final alignment = AlignmentDirectional(0, -1.0);

    final scaleAnimation = _scaleInTransition.animate(animation);
    return FadeTransition(
      opacity: _fadeInTransition.animate(animation),
      child: AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) {
          return ClipRect(
            child: Align(
              alignment: alignment,
              heightFactor: max(scaleAnimation.value, 0.0),
              widthFactor: null,
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}
