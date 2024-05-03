import 'package:flutter/material.dart';

class PageTransition extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    Offset begin = const Offset(1.0, 0.0);
    Offset end = const Offset(0.0, 0.0);

    Animation<Offset> slideTransition =
        Tween(begin: begin, end: end).animate(animation);

    return SlideTransition(
      position: slideTransition,
      child: child,
    );
  }
}
