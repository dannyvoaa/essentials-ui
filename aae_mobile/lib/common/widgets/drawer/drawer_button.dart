import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  // Setup any required variables
  final bool boolActive;
  final bool boolEnabled;
  final String stringTitle;
  final void Function() onTapAction;

  // Initialize the widget
  DrawerButton(
      {this.stringTitle = 'Button',
      this.onTapAction,
      this.boolActive = false,
      this.boolEnabled = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Opacity(
          child: Text(
            stringTitle,
            maxLines: 1,
            style: AaeTextStyles.body().copyWith(
                color: !boolActive ? AaeColors.darkGray : AaeColors.blue),
            overflow: TextOverflow.clip,
          ),
          opacity: boolEnabled ? 1.0 : 0.5,
        ),
        height: AaeDimens.drawerButtonHeight,
      ),
      onTap: this.boolEnabled
          ? () {
              // Check to see if an on-tap action was provided
              if (this.boolEnabled && this.onTapAction != null) {
                // Execute the on-tap action
                this.onTapAction();
              }
            }
          : null,
    );
  }
}
