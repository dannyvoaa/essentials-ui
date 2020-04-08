import 'package:aae/common/commands/aae_command.dart';
import 'package:flutter/material.dart';

/// A convenience [AaeContextCommand] that will navigate to a given route
/// when executed.
///
/// Requires a [BuildContext] so it can use [Navigator] to navigate to [route]
/// with the root navigator.
AaeContextCommand navigateFromRootCommand(String route) =>
    (context) => Navigator.of(context, rootNavigator: true).pushNamed(route);

/// A convenience [AaeContextCommand] that will navigate to a given route
/// when executed.
///
/// Requires a [BuildContext] so it can use [Navigator] to navigate to [route].
/// Does NOT use the root navigator.
AaeContextCommand navigateCommand(String route) =>
    (context) => Navigator.of(context, rootNavigator: false).pushNamed(route);

/// A convenience [AaeValueCommand] that will navigate to a given route
/// with a given [NavigatorState] when executed.
AaeValueCommand navigateWithNavigatorCommand(String route) =>
    (navigator) => navigator.pushNamed(route);
