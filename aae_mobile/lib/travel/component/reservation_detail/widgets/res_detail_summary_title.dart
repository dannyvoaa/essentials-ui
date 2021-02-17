import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:date_format/date_format.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aae/theme/dimensions.dart';

class TripSummaryTitle extends StatelessWidget {
  const TripSummaryTitle({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ReservationDetailViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: AaeDimens.smallCardVerticalContentPadding),
      child: SizedBox(
        height: 53.00,
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                viewModel.reservationDetail.description,
                style: AaeTextStyles.title21MediumGrayMed,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _dateSummary(
                viewModel.reservationDetail.firstDepartureDateTime,
                viewModel.reservationDetail.lastArrivalDateTime,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _dateSummary(String departure, String arrival) {
    List months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    final dep = DateTime.parse(departure);
    final arr = DateTime.parse(arrival);

    // Format month and day text
    final monthFormat = new DateFormat('MMM d');
    final monthText = monthFormat.format(dep) + ' - ' + monthFormat.format(arr);
    // Format departure time
    final timeFormat = new DateFormat('h:mm a');
    final timeText = 'Boards ' + timeFormat.format(dep);

    final text = monthText + ' ' + String.fromCharCode(0x2022) + ' ' + timeText;
    return Text(
      text,
      style: AaeTextStyles.subtitle15,
    );
  }
}