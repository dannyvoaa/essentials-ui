import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:aae/travel/component/checkin/checkin_component.dart';

class TripsPassengerPanel extends StatelessWidget {
  final ReservationDetailViewModel viewModel;
  var travelerList = [1, 2];

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
            child: _passengerList(context),
          ),
        ],
      ),
    );
  }

  _passengerList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: viewModel.reservationDetail.passengers.length,
        separatorBuilder: (context, index){return Divider(color: AaeColors.ultraLightGray, indent: 20, endIndent: 20,);},
        itemBuilder: (context, index) {
          return Container(
            child: _passenger(
                firstName:
                    viewModel.reservationDetail.passengers[index].firstName,
                lastName:
                    viewModel.reservationDetail.passengers[index].lastName,
                passType: viewModel.reservationDetail.passType,
                count: viewModel.reservationDetail.passengers.length,
                index: index
            ),
          );
        },
      ),
    );
  }

  Widget _passenger({String firstName, String lastName, String passType, int count, int index}){
    return Container(
      margin: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: 20,
        right: 20,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 2,
          bottom: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(firstName + ' ' + lastName),
            Text(passType),
          ],
        ),
      ),
    );
  }
}
