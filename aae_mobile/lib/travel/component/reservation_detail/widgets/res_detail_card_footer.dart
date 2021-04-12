import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/model/reservation_detail_segment.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_flight_info.dart';
import 'package:date_format/date_format.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

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
    ReservationDetailPassenger passenger =
    viewModel.reservationDetail.passengers[0];
    ReservationDetailSegment segment =
    viewModel.reservationDetail.segments[index];
    String seat = segment.getSeat(passenger);

    return Container(
      color: AaeColors.superUltralightGray,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _locatorColumn(heading: 'BOARDS', content: getBoarding(viewModel.reservationDetail.segments[index].departureTimeScheduled), alignment: CrossAxisAlignment.start),
          _locatorColumn(heading: 'GATE', content: viewModel.reservationDetail.segments[index].originGate ?? '--', alignment: CrossAxisAlignment.center),
          _locatorColumn(heading: 'TERMINAL', content: viewModel.reservationDetail.segments[index].originTerminal ?? '--', alignment: CrossAxisAlignment.center),
          _locatorColumn(heading: 'BAGGAGE', content: viewModel.reservationDetail.segments[index].baggageClaimArea ?? '--', alignment: CrossAxisAlignment.center),
        ],
      ),
    );
  }

  Widget _locatorColumn({String heading, String content, alignment,}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: alignment,
      children: [
        Text(
          heading,
          style: AaeTextStyles.caption12GrayMed,
        ),
        Container(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            content,
            style: AaeTextStyles.subtitle15,
          ),
        ),
      ],
    );
  }

  String getBoarding(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime boarding = date.subtract(const Duration(minutes: 30));
    String time = formatDate(boarding, [h, ':', nn, ' ', am]);
    return time;
  }

}