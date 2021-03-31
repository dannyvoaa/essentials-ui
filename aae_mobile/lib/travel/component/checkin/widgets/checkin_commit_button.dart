import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

class CheckInButton extends StatelessWidget {
  final Function onClicked;

  CheckInButton({
    @required this.onClicked
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        bottom: 16,
        left: 20,
        right: 20,
      ),
      child: ButtonTheme(
        minWidth: 260.0,
        height: 46.0,
        child: RaisedButton(
          textColor: Colors.white,
          color: AaeColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          onPressed: () {
            if (onClicked != null) onClicked();
          },
          child: Text('Agree and check in', style: AaeTextStyles.btn18),
        ),
      ),
    );
  }
}
