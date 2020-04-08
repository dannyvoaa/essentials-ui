import 'package:flutter/material.dart';

/// Simple MaterialPageRoute subclass that has no transition animation.
class TransitionlessPageRoute<T> extends MaterialPageRoute<T> {
  final WidgetBuilder builder;
  final RouteSettings settings;

  TransitionlessPageRoute({@required this.builder, @required this.settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      child;
}
