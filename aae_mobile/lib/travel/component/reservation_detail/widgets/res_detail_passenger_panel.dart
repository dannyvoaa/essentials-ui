import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:aae/travel/component/checkin/checkin_component.dart';

class TripsPassengerPanel extends StatelessWidget {

  final ReservationDetailViewModel viewModel;
  var travelerList = [1,2];

  TripsPassengerPanel({
    this.viewModel,
    this.travelerList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 16),
              child: Text(
                'Travelers',
                style: AaeTextStyles.subtitle15BlueBold,
                textAlign: TextAlign.left,
                // replaced the inline styles below with the Aae style above
                // style: TextStyle(
                //   fontSize: 15,
                //   color: AaeColors.blue,
                //   fontWeight: FontWeight.w700,
                //   height: 2.6666666666666665,
              ),
            ),
          ),

          Container(
            alignment: Alignment.topLeft,
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
                _passengerList(context),
                CheckInNavButton(),
//                CheckInComponent(pnr: viewModel.reservationDetail.recordLocator),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _passengerList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:12,),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: viewModel.reservationDetail.passengers.length,
        itemBuilder: (context, index) {
          return Container(
            child: Passenger(viewModel.reservationDetail.passengers[index].firstName, viewModel.reservationDetail.passengers[index].lastName, viewModel.reservationDetail.passType, false),
          );
        },
      ),
    );
  }

}


class Passenger extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String status;
  bool isChecked = false;

  Passenger(this.firstName, this.lastName, this.status, this.isChecked);

  @override
  _PassengerState createState() => _PassengerState();
}

class _PassengerState extends State<Passenger> {

  bool isChecked = true;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top:6,bottom:0,left:20,right:20,),
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
                Text(widget.firstName + ' ' + widget.lastName),
                Text(String.fromCharCode(0x2022), style: AaeTextStyles.caption13MediumGrayLS10,),
                Text(widget.status),
              ],
            ),
//            FlutterSwitch(
//              activeColor: AaeColors.blue,
//              inactiveColor: AaeColors.lightGray,
//              toggleColor: AaeColors.white100,
//              width: 40.0,
//              height: 22.0,
//              toggleSize: 20.0,
//              value: isChecked,
//              borderRadius: 30.0,
//              padding: 2.0,
//              showOnOff: false,
//              onToggle: (val) {
//                setState(() {
//                  isChecked = val;
//                });
//              },
//            ),
          ],
        ),
      ),
    );
  }
}

class CheckInNavButton extends StatelessWidget {
  const CheckInNavButton({
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
            print('Check in button a res detail page pressed...');
            Navigator.of(context).pushNamed(
              '/checkin',
            );
          },
          child: Text('Check in', style:AaeTextStyles.btn18),
        ),
      ),
    );
  }
}


