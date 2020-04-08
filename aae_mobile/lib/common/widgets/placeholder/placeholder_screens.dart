import 'package:flutter/material.dart';

/// [AaePlaceholderScreens] is a placeholder class for any screens that would
/// need to be added or are currently in progress but not completed

/// Use this for when you are implementing a new/ are still developing the
/// screen
class AaePlaceholderScreens extends StatelessWidget {
  final String screenAnnote;
  AaePlaceholderScreens({this.screenAnnote});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text('TODO: implement screen for $screenAnnote'),
        ),
      );
}
