import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:aae/travel/component/checkin/widgets/checkin_confirm_card.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';

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
