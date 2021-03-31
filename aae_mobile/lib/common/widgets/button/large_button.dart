import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  // configurable values
  final bool boolEnabled;
  final String stringTitle;
  final void Function() onTapAction;

  // internally used variables
  final Color colorBackground;
  final Color colorHighlight;
  final TextStyle styleText;

  LargeButton.primary(
      {this.stringTitle = 'Button', this.onTapAction, this.boolEnabled = true})
      : colorBackground = AaeColors.blue,
        colorHighlight = AaeColors.blue,
        styleText = AaeTextStyles.subtitle18White;

  LargeButton.secondary(
      {this.stringTitle = 'Button', this.onTapAction, this.boolEnabled = true})
      : colorBackground = Colors.white,
        colorHighlight = AaeColors.blue,
        styleText = AaeTextStyles.subtitle18Blue;

  @override
  Widget build(BuildContext context) {
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
        side: BorderSide(
          color: AaeColors.blue,
        )
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
