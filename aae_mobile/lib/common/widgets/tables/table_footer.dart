import 'package:aae/theme/typography.dart';
import 'package:flutter/widgets.dart';

class TableFooter extends StatelessWidget {
  // Setup any required variables
  final String stringMessage;

  // Initialize the widget
  TableFooter({this.stringMessage = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        stringMessage,
        style: AaeTextStyles.subtitle18Bold1165,
      ),
      margin: EdgeInsets.only(
        left: 16,
        top: 8,
        right: 16,
        bottom: 8,
      ),
    );
  }
}
