import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_view_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoardingPassTripCard extends StatelessWidget {
  const BoardingPassTripCard({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final BoardingPassViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: AaeColors.blue,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: AaeColors.lightGray,
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 18,
              ),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TripCardColumn(
                      heading: 'FLIGHT',
                      content: viewModel.reservationDetail.segments[0].flightNumber.toString(),
                      alignment: CrossAxisAlignment.start,
                      color: 'white'),
                  TripCardColumn(
                      heading: 'BOARDS',
                      content: getTime(viewModel.boardingPasses[0].boardingTime),
                      alignment: CrossAxisAlignment.start,
                      color: 'white'),
                  TripCardColumn(
                      heading: 'DEPARTS',
                      content: getTime(viewModel.boardingPasses[0].departureTime),
                      alignment: CrossAxisAlignment.start,
                      color: 'white'),
                  TripCardColumn(
                      heading: 'GROUP',
                      content: viewModel.boardingPasses[0].groupInfo,
                      alignment: CrossAxisAlignment.center,
                      color: 'white'),
                ],
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 18,
              ),
              decoration: BoxDecoration(
                color: AaeColors.white100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TripCardColumn(
                      heading: 'GATE',
                      content: viewModel.boardingPasses[0].gateInfo ?? '--',
                      alignment: CrossAxisAlignment.start,
                      color: 'gray'),
                  TripCardColumn(
                      heading: 'TERMINAL',
                      content: viewModel.boardingPasses[0].terminal ?? '--',
                      alignment: CrossAxisAlignment.center,
                      color: 'gray'),
                  TripCardColumn(
                      heading: 'BAGGAGE',
                      content: viewModel.reservationDetail.segments[0].baggageClaimArea ?? '--',
                      alignment: CrossAxisAlignment.center,
                      color: 'gray'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTime(String dateStr){
    DateTime date = DateTime.parse(dateStr);
    String time = formatDate(date, [h, ':', nn, ' ', am]);
    return time;
  }

}

class TripCardColumn extends StatelessWidget {
  final String heading;
  final String content;
  final alignment;
  final String color;

  TripCardColumn({this.heading, this.content, this.alignment, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: alignment,
      children: [
        Text(
          heading,
          style: color == 'white'
              ? AaeTextStyles.caption12HalfwayLightGrayMed
              : AaeTextStyles.caption12GrayMed,
        ),
        Container(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            content,
            style: color == 'white'
                ? AaeTextStyles.body16WhiteBold
                : AaeTextStyles.body16Bold,
          ),
        ),
      ],
    );
  }
}
