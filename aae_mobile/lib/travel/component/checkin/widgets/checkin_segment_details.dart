import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:aae/theme/colors.dart';
import 'package:date_format/date_format.dart';
import 'package:aae/theme/dimensions.dart';

class CheckInSegmentDetails extends StatelessWidget {
//  const CheckInSegmentDetails({
//    Key key,
//    @required this.viewModel,
//  }) : super(key: key);

  final CheckInViewModel viewModel;
  final int index;

  CheckInSegmentDetails({
    this.index,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final departureTime = viewModel.reservationDetail.segments[index].departureTimeScheduled;
    final arrivalTime = viewModel.reservationDetail.segments[index].arrivalTimeScheduled;
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 36,),
      decoration: BoxDecoration(
        color: AaeColors.superUltralightGray,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlightNumberColumn(viewModel.reservationDetail.segments[index].flightNumber),
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

//          viewModel.reservationDetail.segments[index].departureTimeScheduled),

class FlightNumberColumn extends StatelessWidget {
  final int flightNumber;

  FlightNumberColumn(this.flightNumber);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image:
          AssetImage('assets/common/american-airlines-eaagle-logo.png'),
          height:30,
        ),
        Text(flightNumber.toString()),
      ],
    );
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
        Text(time, style:AaeTextStyles.subtitle18Bold,),
        Text(location),
      ],
    );
  }
}
