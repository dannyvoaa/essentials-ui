import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:flutter/material.dart';

class FormFieldTitle extends StatelessWidget {
  // Setup any required variables
  final double doubleBottomHeight;
  final String stringTitle;
  final TitleStyle titleStyle;

  // Initialize the widget
  FormFieldTitle({
    this.doubleBottomHeight = Dimensions.size16px,
    @required this.stringTitle,
    this.titleStyle = TitleStyle.Title1,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyleTitle;

    // Check to see which TextStyle was specified
    switch (titleStyle) {
      case TitleStyle.Title1:
        _textStyleTitle = TextStyles.title1();
        break;
      case TitleStyle.Title2:
        _textStyleTitle = TextStyles.title2();
        break;
      case TitleStyle.Title3:
        _textStyleTitle = TextStyles.title3();
        break;
      default:
        _textStyleTitle = TextStyles.title1();
        break;
    }

    return Column(
      children: <Widget>[
        Container(
          child: Text(this.stringTitle, style: _textStyleTitle),
        ),
        SizedBox(
          height: this.doubleBottomHeight,
        ),
      ],
    );
  }
}
