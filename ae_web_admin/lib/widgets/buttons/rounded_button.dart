import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  // Setup any required variables
  final Widget child;
  final Color color;
  final bool enabled;
  final Function() onPressed;

  // Initialize the widget
  RoundedButton({
    @required this.child,
    this.color = BrandColors.blue,
    this.enabled = true,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        child: this.child,
        color: this.color ?? BrandColors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.size4px),
        ),
        disabledColor: BrandColors.lightGray,
        disabledElevation: 0,
        elevation: 0,
        focusElevation: 0,
        highlightColor: CustomColors.transparent,
        highlightElevation: 0,
        hoverElevation: 0,
        onPressed: this.enabled ? this.onPressed : null,
      ),
      height: Dimensions.buttonHeight,
    );
  }
}