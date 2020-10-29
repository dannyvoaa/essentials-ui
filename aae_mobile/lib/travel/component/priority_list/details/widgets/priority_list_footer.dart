import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

class PriorityListFooter extends StatelessWidget {

  final void Function() onUpButtonClicked;

  PriorityListFooter({@required this.onUpButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 40,
            padding: EdgeInsets.only(right:AaeDimens.baseUnit),
            child: FlatButton(
              padding: EdgeInsets.all(0.0),
              child: Icon(
                  AaeIconsv4.upArrow,
                  size: 20,
                  color: AaeColors.lightGray
              ),
              onPressed: onUpButtonClicked,
            ),
          ),
        ],
      ),
    );
  }
}
