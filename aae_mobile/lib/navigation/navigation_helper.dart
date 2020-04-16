import 'package:aae/provided_service.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

/// Utility class to provide an injectable and therefore testable way to handle
/// navigation.
/// Takes care of providing necessary route arguments on pushes.
/// Add new methods as needed. Methods that delegate to [Navigator] should match
/// the type signature of corresponding [Navigator] method exactly except that
/// context is added as the first parameter.
@provide
class AaeNavigator implements ProvidedService {
  /// Pops the top-most route off the navigator.
  void pop<T extends Object>(BuildContext context,
      {T result, bool fromRoot = false}) {
    Navigator.of(context, rootNavigator: fromRoot).pop(result);
  }

  /// Pushes a named route onto the navigator.
  Future<T> pushNamed<T extends Object>(BuildContext context, String routeName,
      {bool fromRoot = false}) {
    return Navigator.of(context, rootNavigator: fromRoot).pushNamed(routeName);
  }

  /// Replaces the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  Future<T> pushReplacementNamed<T extends Object, T0 extends Object>(
      BuildContext context, String routeName,
      {T0 result, bool fromRoot = false}) {
    return Navigator.of(context, rootNavigator: fromRoot)
        .pushReplacementNamed(routeName, result: result);
  }

  /// Removes all routes on the enclosing navigator and replaces them with the
  /// route named [routeName].
  Future<T> replaceAllWithNamed<T extends Object>(
      BuildContext context, String newRouteName,
      {bool fromRoot = false}) {
    return Navigator.of(context, rootNavigator: fromRoot)
        .pushNamedAndRemoveUntil<T>(newRouteName, (_) => false);
  }

  /// Gets a reference to the top-most route on the navigator.
  Route<dynamic> getCurrentRoute(BuildContext context,
      {bool fromRoot = false}) {
    Route currentRoute;
    // popUntil will pass routes to the callback but will only actually pop
    // if the callback returns false. Therefore this will not modify the stack.
    Navigator.of(context, rootNavigator: fromRoot).popUntil((route) {
      currentRoute = route;
      return true;
    });
    return currentRoute;
  }

  /// Removes all routes below the current one, on the root navigator if
  /// [fromRoot] is true, otherwise the closest enclosing navigator.
  void removeAllBelowCurrent(BuildContext context, {bool fromRoot = false}) {
    final currentRoute = getCurrentRoute(context, fromRoot: fromRoot);
    // canPop tests whether there are at least two routes on the stack. If true,
    // can safely remove the one below the current route, since the current
    // route must be the topmost.
    while (Navigator.of(context, rootNavigator: fromRoot).canPop()) {
      Navigator.of(context, rootNavigator: fromRoot)
          .removeRouteBelow(currentRoute);
    }
  }
}
