import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:flutter/material.dart';

class FormFieldRow extends StatelessWidget {
  // Setup any required variables
  final bool boolRightAlign;
  final double doubleBottomHeight;
  final String stringTitle;
  final Widget widget;

  // Initialize the widget
  FormFieldRow({
    this.boolRightAlign = false,
    this.doubleBottomHeight = Dimensions.size16px,
    @required this.stringTitle,
    @required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(this.stringTitle),
              constraints: BoxConstraints(
                minWidth: Dimensions.rowTitle,
              ),
              margin: EdgeInsets.only(
                right: Dimensions.size16px,
              ),
              padding: EdgeInsets.only(
                right: Dimensions.size16px,
              ),
              width: Dimensions.size128px,
            ),
            boolRightAlign
                ? Expanded(
                    child: Container(
                      child: this.widget,
                    ),
                  )
                : Container(
                    child: this.widget,
                  ),
          ],
        ),
        SizedBox(
          height: this.doubleBottomHeight,
        ),
      ],
    );
  }
}
