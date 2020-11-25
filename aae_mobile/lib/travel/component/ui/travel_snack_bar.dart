import 'package:flutter/material.dart';

class TravelSnackBar {
  showSnackBar(BuildContext context, String snackBarText, Color snackBarColor,
      bool popPage) {
    FocusScope.of(context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Container(
            height: 30,
            child: Align(
                alignment: Alignment.center,
                child: Text(snackBarText,
                    style: TextStyle(
                      fontSize: 18,
                    )))),
        backgroundColor: snackBarColor,
        duration: Duration(seconds: 3),
      ));
    });
    if (popPage) {
      Navigator.maybePop(context, '/');
    }
  }
}
