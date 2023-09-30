import 'package:flutter/material.dart';

import '../../../common/utils/disable_glow_behavior.dart';

class AppScrollview extends StatelessWidget {
  final Widget child;

  const AppScrollview({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisableGlowBehavior(),
      child: child,
    );
  }
}
