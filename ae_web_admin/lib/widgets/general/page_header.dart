import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:flutter/widgets.dart';

class PageHeader extends StatelessWidget {
  // Setup any required variables
  final String stringTitle;
  final Widget widgetActions;

  // Initialize the widget
  PageHeader({
    @required this.stringTitle,
    @required this.widgetActions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              this.stringTitle,
              style: TextStyles.title1(),
            ),
            widgetActions ?? Container(),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        height: Dimensions.size48px,
        margin: EdgeInsets.only(
          bottom: Dimensions.size16px,
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColors.separator,
            width: Dimensions.size1px,
          ),
        ),
      ),
    );
  }
}
