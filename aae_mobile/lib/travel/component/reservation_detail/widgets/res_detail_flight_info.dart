import 'package:aae/assets/aae_icons.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/model/reservation_detail_segment.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:date_format/date_format.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class FlightInfo extends StatelessWidget {
  final ReservationDetailViewModel viewModel;
  final int index;

  FlightInfo({
    this.index,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    var originAirportCode = viewModel.reservationDetail.segments[index].originAirportCode;
    var destinationAirportCode = viewModel.reservationDetail.segments[index].destinationAirportCode;

    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: ExpandableTheme(
        data: ExpandableThemeData(
          iconColor: AaeColors.lightGray,
          animationDuration: const Duration(milliseconds: 100),
          iconRotationAngle: 1.55,
          hasIcon: true,
          tapBodyToExpand: true,
          expandIcon: Icons.arrow_forward_ios,
          collapseIcon: Icons.arrow_forward_ios,
        ),
        child: Container(
          child: ExpandablePanel(
            header: _routeSummary(viewModel: viewModel, index: index),
            expanded: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Column(
                children: [
                  _routeDetail(viewModel: viewModel, index: index),
                  _travelerSeats(
                    viewModel: viewModel,
                    index: index,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _routeSummary({ReservationDetailViewModel viewModel, int index}) {
    String getTime(String dateStr) {
      DateTime date = DateTime.parse(dateStr);
      String time = formatDate(date, [h, ':', nn, ' ', am]);
      return time;
    }

    bool _checkedIn() {
      if (viewModel.reservationDetail.segments[index].passengerInfo.every((e) => e.checkedIn == true)) {
        return true;
      } else {
        return false;
      }
    }

    Widget _routeSummaryColumn({String time, String location, bool checkedIn}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: AaeTextStyles.subtitle18Med,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Text(location, style: AaeTextStyles.body14),
                ),
                SizedBox(
                  height:20,
                  width:20,
                  child: Icon(
                    AmericanIconsv4_6.checkMark,
                    size: checkedIn ? 15 : 0,
                    color: AaeColors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(
        right: 60,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _routeSummaryColumn(
            time: getTime(viewModel.reservationDetail.segments[index].departureTimeScheduled),
            location: viewModel.reservationDetail.segments[index].originAirportCode,
            checkedIn: _checkedIn(),
          ),
          Icon(
            Icons.arrow_forward,
            color: AaeColors.gray,
          ),
          _routeSummaryColumn(
            time: getTime(viewModel.reservationDetail.segments[index].arrivalTimeScheduled),
            location: viewModel.reservationDetail.segments[index].destinationAirportCode,
            checkedIn: false,
          ),
        ],
      ),
    );
  }

  Widget _routeDetail({ReservationDetailViewModel viewModel, int index}) {

    const cabinLabels = {
      "PREMIUM": "Premium",
      "FIRST": "First",
      "BUSINESS": "Business",
      "PREMIUM_COACH": "Prem Econ",
      "PREMIUMECONOMY": "Prem Econ",
      "MAIN": "Main",
      "COACH": "Main"
    };

    String cabinName(String cabin){
      if (cabinLabels.containsKey(cabin))
        return cabinLabels[cabin];
      else
        return cabin;
    }

    String duration(int minutes) {
      var hours = (minutes / 60).floor();
      var mins = minutes - (hours * 60);
      String duration = hours.toString() + 'hr ' + mins.toString() + 'min';
      return duration;
    }

    Widget _airportName({ReservationDetailViewModel viewModel, int index, bool dest}) {
      final String airportCode = dest ? viewModel.reservationDetail.segments[index].destinationAirportCode : viewModel.reservationDetail.segments[index].originAirportCode;
      final String airportName = viewModel.getAirportName(airportCode) ?? viewModel.reservationDetail.segments[index].originCity;
      final String nameAndCode = airportName + ' (' + airportCode + ')';

      return Text(nameAndCode);
    }

    Widget _overnight(String departure, String arrival) {
      DateTime startTime = DateTime.parse(departure);
      DateTime finishTime = DateTime.parse(arrival);
      int startDay = startTime.day;
      int finishDay = finishTime.day;

      if (startDay == finishDay) {
        return Text('');
      } else {
        return Row(
          children: [
            Text(
              'Overnight',
              style: AaeTextStyles.caption12Gray,
            ),
            Text(
              String.fromCharCode(0x2022),
              style: AaeTextStyles.caption12Gray,
            )
          ],
        );
      }
    }

    Widget _wifi({bool hasWifi}) {
      if (hasWifi = true) {
        return Row(
          children: [
            Text(
              ' ' + String.fromCharCode(0x2022) + ' ',
              style: AaeTextStyles.caption12Gray,
            ),
            Icon(
              Icons.wifi,
              color: AaeColors.gray,
              size: 14,
            ),
          ],
        );
      } else {
        return Text('');
      }
    }

    Widget _detailText({String content}) {
      return Text(
        content,
        style: AaeTextStyles.caption12Gray,
      );
    }

    Widget _dividerDot() {
      return Text(
        ' ' + String.fromCharCode(0x2022) + ' ',
        style: AaeTextStyles.caption12Gray,
      );
    }

    Widget _circleRoute() {
      return Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 12,
            width: 12,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: AaeColors.lightGray,
                width: 1,
              ),
              color: AaeColors.white100,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          SizedBox(
            width: 1.0,
            height: 46.0,
            child: OverflowBox(
              maxHeight: 50.0,
              child: Container(
                padding: EdgeInsets.only(
                  top: 12,
                ),
                color: AaeColors.lightGray,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: 12,
            width: 12,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: AaeColors.lightGray,
                width: 1,
              ),
              color: AaeColors.white100,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _circleRoute(),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: _airportName(viewModel: viewModel, index: index, dest: false),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      duration(viewModel.reservationDetail.segments[index].duration),
                      style: AaeTextStyles.caption12Gray,
                    ),
                    _dividerDot(),
                    _overnight(viewModel.reservationDetail.segments[index].departureTimeScheduled, viewModel.reservationDetail.segments[index].arrivalTimeScheduled),
                    _detailText(content: viewModel.reservationDetail.segments[index].aircraftName),
                    _dividerDot(),
                    _detailText(content: cabinName(viewModel.reservationDetail.segments[index].cabin)),
                    _wifi(hasWifi: viewModel.reservationDetail.segments[index].hasWifi),
                  ],
                ),
              ),
              Container(
                child: _airportName(viewModel: viewModel, index: index, dest: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _travelerSeats({ReservationDetailViewModel viewModel, int index}) {
    Widget _passenger({String firstName, String lastName, String seat}) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(
          top: 6,
          bottom: 0,
          left: 0,
          right: 0,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: AaeColors.ultraLightGray),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 16,
            bottom: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(firstName + ' ' + lastName),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: AaeColors.superUltralightGray,
                    ),
                    child: Text(
                      'SEAT',
                      style: AaeTextStyles.caption11GrayMed,
                    ),
                  ),
                  Text(seat, style: AaeTextStyles.subtitle15),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 12),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: viewModel.reservationDetail.passengers.length,
        itemBuilder: (context, index) {
          return Container(
            child: _passenger(
              firstName: viewModel.reservationDetail.passengers[index].firstName,
              lastName: viewModel.reservationDetail.passengers[index].lastName,
              seat: viewModel.reservationDetail.segments[0].getSeat(viewModel.reservationDetail.passengers[index]) ?? "--",
            ),
          );
        },
      ),
    );
  }
}
