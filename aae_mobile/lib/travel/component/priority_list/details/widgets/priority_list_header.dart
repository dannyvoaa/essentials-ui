import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../priority_list_view_model.dart';

class PriorityListHeader extends StatelessWidget {
  final PriorityListViewModel viewModel;

  static const smallTextStyle = TextStyle(
    fontFamily: 'AmericanSans',
    fontSize: 18,
    color: const Color(0xff627a88),
  );

  static const largeTextStyle = TextStyle(
    fontFamily: 'AmericanSansMedium',
    fontSize: 38,
    color: const Color(0xff627a88),
  );

  final aaLogo = Image.asset(
    'assets/common/flight_symbol.png',
    width: AaeDimens.sizeDynamic_16px(),
  );

  final dateFormat = DateFormat('EEEE, MMM d, y');
  final timeFormat = DateFormat.jm();

  final bulletDivider = Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        color: const Color(0xff627a88),
      ),
      width: 3.0,
      height: 3.0,
    ),
  );

  PriorityListHeader(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AaeDimens.baseUnit,
          top: AaeDimens.baseUnit * 1.5,
          right: AaeDimens.baseUnit,
          bottom: AaeDimens.baseUnit ,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                aaLogo,
                Text(viewModel.priorityList.flightNumber.toString(),
                    style: smallTextStyle),
                bulletDivider,
                Text(
                  "Gate ${viewModel.priorityList.departureGate}",
                  style: smallTextStyle,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: AaeDimens.baseUnit/2,
                bottom: AaeDimens.baseUnit/2,
              ),
              child: Text(
                viewModel.priorityList.originAirportCode +
                    " to " +
                    viewModel.priorityList.destinationAirportCode,
                style: largeTextStyle,

              ),
            ),
            Row(
              children: [
                Text(
                  dateFormat.format(DateTime.parse(viewModel.priorityList.departureTime)),
                  style: smallTextStyle,
                ),
                bulletDivider,
                Text(
                  timeFormat.format(DateTime.parse(viewModel.priorityList.departureTime)),
                  style: smallTextStyle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
