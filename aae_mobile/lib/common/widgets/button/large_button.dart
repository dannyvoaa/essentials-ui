import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  // Setup any required variables
  final bool boolEnabled;
  final String stringTitle;
  final void Function() onTapAction;

  // Initialize the widget
  LargeButton(
      {this.stringTitle = 'Button', this.onTapAction, this.boolEnabled = true});

  @override
  Widget build(BuildContext context) {
    // Setup any required variables
    Color colorBackground;
    Color colorHighlight;
    TextStyle styleText;

    // Use the Light Blue color theme
    colorBackground = AaeColors.blue;
    colorHighlight = AaeColors.blue;
    styleText = AaeTextStyles.btn18;

    return FlatButton(
      child: Text(
        stringTitle,
        style: styleText,
      ),
      color: colorBackground,
      disabledColor: colorBackground.withOpacity(0.60),
      highlightColor: colorHighlight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AaeDimens.roundedCorner),
      ),
      splashColor: Colors.transparent,
      onPressed: this.boolEnabled
          ? () {
              // Check to see if an on-tap action was provided
              if (this.boolEnabled && this.onTapAction != null) {
                // Execute the on-tap action
                this.onTapAction();
              }
            }
          : null,
      padding: EdgeInsets.all(AaeDimens.buttonContentPadding),
    );
  }
}
