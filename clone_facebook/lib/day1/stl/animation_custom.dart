import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';

class AnimationCustom extends StatelessWidget {
  const AnimationCustom({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: const Duration(milliseconds: 500),
      child: child,
    );
  }
}
