import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:aae/travel/component/checkin/checkin_component.dart';

class ReservationDetailCheckInButton extends StatelessWidget {
  const ReservationDetailCheckInButton({
    Key key,
  }) : super(key: key);

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
            print('Check in button a res detail page pressed...');
            Navigator.of(context).pushNamed(
              '/checkin',
            );
          },
          child: Text('Check in', style: AaeTextStyles.btn18),
        ),
      ),
    );
  }
}