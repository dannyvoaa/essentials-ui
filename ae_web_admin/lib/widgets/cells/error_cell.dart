import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:flutter/material.dart';

class ErrorCell extends StatelessWidget {
  // Setup any required variables
  final String stringMessage;

  // Initialize the widget
  ErrorCell({
    @required this.stringMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(stringMessage),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColors.separator,
            width: Dimensions.sizeDivider,
          ),
        ),
      ),
      height: Dimensions.size48px,
    );
  }
}
