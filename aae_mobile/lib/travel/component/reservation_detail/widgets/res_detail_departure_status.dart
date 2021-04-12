import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/model/reservation_detail_segment.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_card_footer.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_flight_info.dart';
import 'package:date_format/date_format.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class DepartureStatus extends StatelessWidget {
  final ReservationDetailViewModel viewModel;
  final int index;

  DepartureStatus({
    this.index,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.only(
      left: 0,
      right: 20,
    );
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Image(
                image: AssetImage(
                    'assets/common/american-airlines-eaagle-logo.png'),
                height: 30,
              ),
              countDown(
                index,
                context,
              ),
            ],
          ),
          Text(
            viewModel.reservationDetail.segments[index].status,
            style: AaeTextStyles.caption12GreenMed,
          ),
        ],
      ),
    );
  }

  Widget countDown(index, BuildContext context) {
    final number =
    viewModel.reservationDetail.segments[index].flightNumber.toString();

    final scheduled =
        viewModel.reservationDetail.segments[index].departureTimeScheduled;
    final actual =
        viewModel.reservationDetail.segments[index].departureTimeActual;

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
    var minuteText;
    var departText;

    if (days > 0 && days != 1) {
      dayText = days.toString() + ' days ';
    } else if (days == 1) {
      dayText = days.toString() + ' day ';
    } else {
      dayText = '';
    }

    if (remainingHours > 0) {
      hourText = remainingHours.toString() + ' hrs ';
    } else {
      hourText = '';
    }

    if (remainingMinutes > 0){
      minuteText = remainingMinutes.toString() + ' min';
      departText = ' departs in ';
    } else {
      minuteText = '';
      departText = '';
    }

    final text = number + departText + dayText + hourText + minuteText;
    return Text(text, style: AaeTextStyles.caption12);
  }
}