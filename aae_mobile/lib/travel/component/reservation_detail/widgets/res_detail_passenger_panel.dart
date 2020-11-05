import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:expandable/expandable.dart';
import 'package:custom_switch_button/custom_switch_button.dart';

class TripsPassengerPanel extends StatelessWidget {

  const TripsPassengerPanel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                'Travelers',
                style: TextStyle(
                  fontSize: 15,
                  color: AaeColors.blue,
                  fontWeight: FontWeight.w700,
                  height: 2.6666666666666665,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
//      padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: const Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29131313),
                  offset: Offset(0, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
//                _passengerList(context),
                PassengerList(),
                CheckInButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PassengerList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Passenger('BENJAMIN FRANKLIN', 'D2', true),
        Passenger('ABRAHAM LINCOLN', 'D3', true),
      ],
    );
  }
}


class Passenger extends StatelessWidget {
  final String name;
  final String status;
  bool isChecked = false;

  Passenger(this.name, this.status, this.isChecked);

  @override
  Widget build(BuildContext context){
    return Container(
//      padding: EdgeInsets.only(top:10,bottom:10,left:20,right:20,),
      margin: EdgeInsets.only(top:10,bottom:0,left:20,right:20,),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: AaeColors.ultraLightGray),),
      ),
      child: Padding(
        padding: EdgeInsets.only(top:6,bottom:8,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Text(name),
                Text(String.fromCharCode(0x2022), style: AaeTextStyles.dividerDot,),
                Text(status),
              ],
            ),
            CustomSwitchButton(
              buttonHeight: 30,
              buttonWidth: 60,
              indicatorWidth: 26,
              indicatorBorderRadius: 50,
              backgroundBorderRadius: 20,
              backgroundColor: AaeColors.blue,
              unCheckedColor: AaeColors.white,
              animationDuration: Duration(milliseconds: 200),
              checkedColor: AaeColors.white,
              checked: isChecked,
            ),
          ],
        ),
      ),
    );
  }
}

class CheckInButton extends StatelessWidget {
  const CheckInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:16,bottom:16,left:20,right:20,),
      child: ButtonTheme(
        minWidth: 260.0,
        height: 46.0,
        child: RaisedButton(
          textColor: Colors.white,
          color: AaeColors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0),),
          onPressed: () {
            print('Check in pressed...');
          },
          child: Text('Check in', style:AaeTextStyles.checkInButton),
        ),
      ),
    );
  }
}
