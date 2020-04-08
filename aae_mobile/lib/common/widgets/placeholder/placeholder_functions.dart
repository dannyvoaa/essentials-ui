import 'package:flutter/material.dart';

/// [PlaceholderSnackBar] is a static widget that would appear when invoked

/// Use this when you are building an action to an interaction

class PlaceholderSnackBar {
  /// [aaeIdentifier] is a static field that will hold the value of the

  /// identifer from the component that invokes it.

  final String _aaeIdentifier;

  /// [snackBar] will have the SnackBar widget that will appear on screen

  final Widget _snackBar;

  /// [context] is the context of the application and will have the current

  ///  state status of the stack.

  final BuildContext _context;

  PlaceholderSnackBar({
    @required String aaeIdentifier,
    @required BuildContext context,
  })  : this._aaeIdentifier = aaeIdentifier,
        this._context = context,
        this._snackBar = SnackBar(
          content: Text('TODO implement $aaeIdentifier'),
        );

  void show() {
    // TODO: (rpaglinawan) show snack bar until dismissed

    debugPrint('TODO implement ${this._aaeIdentifier}');

    Scaffold.of(this._context).showSnackBar(this._snackBar);
  }
}
