import 'package:flutter/material.dart';

/// A AaeCommand encapsulates complex logic that can be executed at a later
/// time. Classes that implement this should add all of that logic in their
/// version of the function.
///
/// Views are the consumers of Commands (they call the function), BLoCs are the
/// creators of Commands, and ViewModels are the holders of Commands.
///
typedef AaeCommand = void Function();

/// A AaeContextCommand encapsulates complex logic that can be executed at a
/// later time. Classes that implement this should add all of that logic in
/// their version of the function. This allows [BuildContext] specific actions
/// to be executed.
///
/// Views are the consumers of Commands (they call the function with a
/// [BuildContext]), BLoCs are the creators of Commands, and ViewModels are the
/// holders of Commands.
///
typedef AaeContextCommand = void Function(BuildContext context);

/// A AaeValueCommand encapsulates complex logic that can be executed at a
/// later time. Classes that implement this should add all of that logic in
/// their version of the function. This allows actions to be
/// executed with a given value, which is useful for things like [Dropdown]
/// menus so each menu item doesn't need to be given its own command.
///
/// Views are the consumers of Commands (they call the function with a value),
/// BLoCs are the creators of Commands, and ViewModels are the holders of
/// Commands.
///
typedef AaeValueCommand<T> = void Function(T value);
