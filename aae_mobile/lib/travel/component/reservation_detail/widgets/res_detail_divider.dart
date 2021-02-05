import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class StopDivider extends StatelessWidget {
  final ReservationDetailViewModel viewModel;
  final int index;

  StopDivider({
    this.index,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final dest =
    (viewModel.reservationDetail.segments[index].destinationAirportCode)
        .toString();
    final stopText = 'Stop: ' + dest;
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 6,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: _dottedDivider(),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                stopText,
                style: AaeTextStyles.caption12MediumGrayMed,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: _dottedDivider(),
            ),
          ),
        ],
      ),
    );
  }

  _dottedDivider() {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: AaeColors.darkOrange,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}