import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/model/reservation_detail_segment.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_card_footer.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_departure_status.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_flight_info.dart';
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
          DepartureStatus(
            index: index,
            viewModel: viewModel,
          ),
          FlightInfo(
            index: index,
            viewModel: viewModel,
          ),
          LocatorInfo(
            index: index,
            viewModel: viewModel,
          ),
        ],
      ),
    );
  }
}
