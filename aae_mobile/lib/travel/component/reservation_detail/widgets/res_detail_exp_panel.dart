import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:date_format/date_format.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class TripDetailExpandPanel extends StatelessWidget {

  final ReservationDetailViewModel viewModel;
  final int index;

  TripDetailExpandPanel({
    this.index,
    this.viewModel,
  });




  @override
  Widget build(BuildContext context) {
    return Container(
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
          DepartureStatus(index: index, viewModel: viewModel,),
          RouteInfo(index: index, viewModel: viewModel,),
          LocatorInfo(index: index, viewModel: viewModel,),
        ],
      ),
    );
  }
}

class RouteInfo extends StatelessWidget {
  final ReservationDetailViewModel viewModel;
  final int index;

  RouteInfo({
    this.index,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
            header: RouteSummary(index: index, viewModel: viewModel,),
            expanded: Padding(
              padding: const EdgeInsets.only(top:14),
              child: Column(
                children: [
                  RouteDetail(
                    viewModel.reservationDetail.segments[index].originCity + ' (' + viewModel.reservationDetail.segments[index].originAirportCode + ')',
                    duration(viewModel.reservationDetail.segments[index].duration),
                    overnight(viewModel.reservationDetail.segments[index].departureTimeScheduled, viewModel.reservationDetail.segments[index].arrivalTimeScheduled),
                    viewModel.reservationDetail.segments[index].cabin ,
                    viewModel.reservationDetail.segments[index].aircraftName,
                    wifi(viewModel.reservationDetail.segments[index].hasWifi),
                  ),
                  RouteDetailEnd(viewModel.reservationDetail.segments[index].destinationAirportCode, viewModel.reservationDetail.segments[index].destinationCity),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _routeDetails(list) {
    return Padding(
      padding: EdgeInsets.only(top:12,),
      child: SizedBox(
        height: 58.00 * list.length,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Container(
            height: 80,
            width: 80,
              child: RouteDetail(
                  list.originCity + ' (' + viewModel.reservationDetail.segments[index].originAirportCode + ')',
                  duration(viewModel.reservationDetail.segments[index].duration),
                  overnight(viewModel.reservationDetail.segments[index].departureTimeScheduled, viewModel.reservationDetail.segments[index].arrivalTimeScheduled),
                  viewModel.reservationDetail.segments[index].cabin ,
                  viewModel.reservationDetail.segments[index].aircraftName,
                  wifi(viewModel.reservationDetail.segments[index].hasWifi),
              ),
            );
          },
        ),
      ),
    );
  }

  String duration(int minutes){
    var hours = (minutes / 60).floor();
    var mins = minutes - (hours * 60);
    String duration = hours.toString() + 'hr ' + mins.toString() + 'min';
    return duration;
  }

  Widget overnight(String departure, String arrival){
    DateTime startTime = DateTime.parse(departure);
    DateTime finishTime = DateTime.parse(arrival);
    int startDay = startTime.day;
    int finishDay = finishTime.day;

    if (startDay == finishDay) {
      return Text('');
    } else {
      return Row(
        children: [
          Text('Overnight', style: AaeTextStyles.caption13MediumGray,),
          Text(String.fromCharCode(0x2022), style: AaeTextStyles.caption13MediumGrayLS10,)
        ],
      );
    }
  }

  Widget wifi(bool hasWifi){
    if (hasWifi = true) {
      return Row(
        children: [
          Text(String.fromCharCode(0x2022), style: AaeTextStyles.caption13MediumGrayLS10,),
          Icon(Icons.wifi, color:AaeColors.ultraLightGray, size: 12,),
        ],
      );
    } else {
      return Text('');
    }
  }
}

class RouteSummary extends StatelessWidget {
  final ReservationDetailViewModel viewModel;
  final int index;

  RouteSummary({
    this.index,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {

    final departureTime = viewModel.reservationDetail.segments[index].departureTimeScheduled;
    final arrivalTime = viewModel.reservationDetail.segments[index].arrivalTimeScheduled;

    return Container(
      margin: EdgeInsets.only(
        right: 80,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RouteSummaryColumn(getTime(departureTime), viewModel.reservationDetail.segments[index].originAirportCode),
          Icon(Icons.arrow_forward, color: AaeColors.gray,),
          RouteSummaryColumn(getTime(arrivalTime), viewModel.reservationDetail.segments[index].destinationAirportCode),
        ],
      ),
    );
  }

  String getTime(String dateStr){
    DateTime date = DateTime.parse(dateStr);
    String time = formatDate(date, [h, ':', nn, ' ', am]);
    return time;
  }

}

class RouteSummaryColumn extends StatelessWidget {
  final String time;
  final String location;

  RouteSummaryColumn(this.time, this.location);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time, style:AaeTextStyles.subtitle18Med,),
        Text(location, style: AaeTextStyles.body14),
      ],
    );
  }
}

class RouteDetailEnd extends StatelessWidget {
  final String hub;
  final String city;
  const RouteDetailEnd(this.hub, this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 20,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom:4,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: 12,
              width: 12,
              padding: EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AaeColors.ultraLightGray,
                  width: 1,
                ),
                color: AaeColors.white100,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Container(child: cityHub(hub, city),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cityHub(hub, city){
    final text = city + ' (' + hub + ')';
    return Text(text, style:AaeTextStyles.body14);
  }
}

class RouteDetail extends StatelessWidget {
  final String hub;
  final String duration;
  final Widget overnight;
  final String cabin;
  final String equipment;
  final Widget wifi;
  const RouteDetail(this.hub, this.duration, this.overnight, this.cabin,
      this.equipment, this.wifi);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleRoute(),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: Text(hub, style:AaeTextStyles.body14)),
              Padding(
                padding: const EdgeInsets.only(top:12, bottom:12,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(duration, style: AaeTextStyles.caption13MediumGray,),
                    Text(String.fromCharCode(0x2022), style: AaeTextStyles.caption13MediumGrayLS10,),
                    overnight,
                    Text(cabin, style: AaeTextStyles.caption13MediumGray,),
                    Text(String.fromCharCode(0x2022), style: AaeTextStyles.caption13MediumGrayLS10,),
                    Text(equipment, style: AaeTextStyles.caption13MediumGray,),
                    wifi,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: 12,
          width: 12,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: AaeColors.ultraLightGray,
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
              padding: EdgeInsets.only(top:12,),
              color: AaeColors.ultraLightGray,
            ),
          ),
        ),
      ],
    );
  }
}

/// Locator information band at the bottom of the expanded view widget

class LocatorInfo extends StatelessWidget {
  final ReservationDetailViewModel viewModel;
  final int index;

  LocatorInfo({
    this.index,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {

    String seat = viewModel.reservationDetail.segments[index].seatAssignments[0].seatAssignment;

    return Container(
      color: AaeColors.superUltralightGray,
      padding: EdgeInsets.only(left:20, right:20, top:8, bottom:8,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          LocatorColumn('LOCATOR', viewModel.reservationDetail.recordLocator, CrossAxisAlignment.start),
          LocatorColumn('GATE', viewModel.reservationDetail.segments[index].originGate, CrossAxisAlignment.center),
          LocatorColumn('TERMINAL', viewModel.reservationDetail.segments[index].originTerminal, CrossAxisAlignment.center),
          LocatorColumn('BAGGAGE', nonNull(seat), CrossAxisAlignment.end),
        ],
      ),
    );
  }

  String nonNull(String x){
    if (x == null){
      return '--';
    } else {
      return x;
    }
  }
}

class LocatorColumn extends StatelessWidget {
  final String heading;
  final String content;
  final alignment;

  LocatorColumn(this.heading, this.content, this.alignment);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: alignment,
      children: [
        Text(
          heading,
          style: AaeTextStyles.caption12GrayMed,
        ),
        Container(
          padding: EdgeInsets.only(top:6),
          child: Text(
            content,
            style: AaeTextStyles.subtitle15,
          ),
        ),
      ],
    );
  }
}

class DepartureStatus extends StatelessWidget {
  final ReservationDetailViewModel viewModel;
  final int index;

  DepartureStatus({
    this.index,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.only(left:0, right:20,);
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Image(
                image:
                AssetImage('assets/common/american-airlines-eaagle-logo.png'),
                height:30,
              ),
              countDown(index, context,),
            ],
          ),
          Text(viewModel.reservationDetail.segments.first.status, style: AaeTextStyles.caption12GreenMed,),
        ],
      ),
    );
  }

  Widget countDown(index, BuildContext context){

    final number = viewModel.reservationDetail.segments[index].flightNumber.toString();

    final scheduled = viewModel.reservationDetail.segments[index].departureTimeScheduled;
    final actual = viewModel.reservationDetail.segments[index].departureTimeActual;

    var now = DateTime.now();

    var departure;

    if (actual != null) {
      departure = DateTime.parse(actual);
    } else {
      departure = DateTime.parse(scheduled);
    }

    final days = departure.difference(now).inDays;
    final hours = departure.difference(now).inHours;
    final remainingHours = hours - (days * 24);
    final minutes = departure.difference(now).inMinutes;
    final remainingMinutes = (minutes - (days * 1440)) - (remainingHours * 60);

    var dayText;
    var hourText;
    var minuteText = remainingMinutes.toString() + ' min';

    if (days > 0){
      dayText = days.toString() + ' days ';
    } else {
      dayText = '';
    }

    if (remainingHours > 0){
      hourText = remainingHours.toString() + ' hrs ';
    } else {
      hourText = '';
    }

    final text = number + ' departs in ' + dayText + hourText + minuteText;
    return Text(text, style:AaeTextStyles.caption12);
  }
}


