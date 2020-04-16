import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:flutter/material.dart';

class HeaderCell extends StatelessWidget {
  // Setup any required variables
  final String stringTitle;
  final String stringTitleSecondary;

  // Initialize the widget
  HeaderCell({
    @required this.stringTitle,
    this.stringTitleSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            this.stringTitle,
            style: TextStyles.title2(),
          ),
          Text(
            this.stringTitleSecondary ?? '',
            style: TextStyles.title2(),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
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
