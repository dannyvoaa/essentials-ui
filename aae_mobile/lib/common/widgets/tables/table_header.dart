import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  // Setup any required variables
  final String stringTitle;

  // Initialize the widget
  TableHeader({this.stringTitle = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        stringTitle.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AaeTextStyles.subtitle18Bold1165,
      ),
      margin: EdgeInsets.only(
        left: AaeDimens.baseUnit,
        top: 16,
        right: 16,
        bottom: 8,
      ),
    );
  }
}
