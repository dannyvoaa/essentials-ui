import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CheckInTravelerSelect extends StatelessWidget {
  const CheckInTravelerSelect({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CheckInViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: const Color(0xffffffff),
//        boxShadow: [
//          BoxShadow(
//            color: const Color(0x29131313),
//            offset: Offset(0, 2),
//            blurRadius: 3,
//          ),
//        ],
      ),
      child: Column(
        children: <Widget>[
          _passengerList(context),
//          CheckInNavButton(),
//                CheckInComponent(pnr: viewModel.reservationDetail.recordLocator),
        ],
      ),
    );
  }

  _passengerList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: viewModel.reservationDetail.passengers.length,
        itemBuilder: (context, index) {
          var currentPassenger = viewModel.reservationDetail.passengers[index];
          return Container(
            child: PassengerSlider(
              firstName: currentPassenger.firstName,
              lastName: currentPassenger.lastName,
              status: viewModel.reservationDetail.passType,
              isChecked: true,
              onToggle: (enabled)=>{
                if (enabled) {
                  viewModel.setTravelerForCheckIn(currentPassenger.nrsTravelerId)
                } else {
                  viewModel.removeTravelerForCheckIn(currentPassenger.nrsTravelerId)
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class PassengerSlider extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String status;
  bool isChecked = false;
  final Function(bool enabled) onToggle;

  PassengerSlider(
      {this.firstName,
      this.lastName,
      this.status,
      this.isChecked,
      this.onToggle});

  @override
  _PassengerSliderState createState() => _PassengerSliderState();
}

class _PassengerSliderState extends State<PassengerSlider> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 6,
        bottom: 0,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AaeColors.ultraLightGray),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 6,
          bottom: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Text(widget.firstName + ' ' + widget.lastName),
                Text(
                  String.fromCharCode(0x2022),
                  style: AaeTextStyles.caption13MediumGrayLS10,
                ),
                Text(widget.status),
              ],
            ),
            FlutterSwitch(
              activeColor: AaeColors.blue,
              inactiveColor: AaeColors.ultraLightGray,
              toggleColor: AaeColors.white100,
              width: 40.0,
              height: 22.0,
              toggleSize: 20.0,
              value: isChecked,
              borderRadius: 30.0,
              padding: 2.0,
              showOnOff: false,
              onToggle: (val) {
                setState(() {
                  isChecked = val;
                  widget.onToggle(isChecked);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

//class CheckInNavButton extends StatelessWidget {
//  const CheckInNavButton({
//    Key key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.only(top:16,bottom:16,left:20,right:20,),
//      child: ButtonTheme(
//        minWidth: 260.0,
//        height: 46.0,
//        child: RaisedButton(
//          textColor: Colors.white,
//          color: AaeColors.blue,
//          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0),),
//          onPressed: () {
//            print('Check in pressed...');
////            Navigator.of(context).pushNamed(
////              '/checkin',
////            );
//          },
//          child: Text('Check in', style:AaeTextStyles.checkInButton),
//        ),
//      ),
//    );
//  }
//}
