import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

class ToolsButton extends StatelessWidget {
  ToolsButton({this.iconData, this.title, this.subtitle});

  final IconData iconData;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return _buildToolsButton(context);
  }

  _buildToolsButton(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                height: 30,
                width: 30,
                child: Icon(iconData, size: 30, color: AaeColors.blue))
          )),
      Expanded(
          flex: 6,
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Text(
                    '$title',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'AmericanSansMedium',
                      fontSize: 16,
                      color: AaeColors.darkGray,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    '$subtitle',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13,
                      color: AaeColors.mediumGray,
                    ),
                  ),
                )
              ]))),
    ]);
  }
}
