import 'package:aae/assets/aae_icons.dart';
import 'package:aae/model/priority_list_passenger.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/priority_list/details/widgets/priority_list_flight_inventory_card.dart';
import 'package:aae/travel/component/priority_list/details/widgets/priority_passenger_list.dart';
import 'package:flutter/material.dart';

class PriorityListPassengerListItem extends StatelessWidget {
  final PriorityListPassenger passenger;
  final PriorityPassengerListType type;

  static const largeTextStyle = TextStyle(
    fontFamily: 'AmericanSans',
    fontSize: 18,
    color: const Color(0xff36495a),
    letterSpacing: 0.18,
  );

  static const largeTextStyleSeatAssigned = TextStyle(
    fontFamily: 'AmericanSans',
    fontSize: 18,
    color: const Color(0xff008712),
    letterSpacing: 0.18,
  );

  static const priorityCodeTextStyle = TextStyle(
    fontFamily: 'AmericanSans',
    fontSize: 14,
    color: const Color(0xff36495a),
  );

  static const secondRowTextStyle = TextStyle(
    fontFamily: 'AmericanSans',
    fontSize: 14,
    color: const Color(0xff9da6ab),
  );

  final bulletDivider = _buildBulletDivider(const Color(0xff627a88));
  final lightBulletDivider = _buildBulletDivider(const Color(0xff9da6ab));

  PriorityListPassengerListItem({this.passenger, this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:15, bottom: 15),
      margin: EdgeInsets.only(
        bottom: 0,
        left: 16,
        right: 16,
      ),
      decoration:  BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5, color: const Color(0x82707070),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // header row
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${passenger.priorityNumber}. ${passenger.lastName} / ${passenger.firstName}",
                  style: _isSeatAssignedIndicatorNeeded() ? largeTextStyleSeatAssigned : largeTextStyle,
                ),
                ..._buildSeatAssignedIcon(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        passenger.priorityCode ?? "",
                        style: priorityCodeTextStyle,
                      ),
                      ..._buildRemarksWidget()
                    ],
                  ),
                ),
              ],
            ),
          ),
          DefaultTextStyle(
            style: secondRowTextStyle,
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: AaeDimens.baseUnit,
              ),
              child: Row(
                children: [
                  // we try to map the cabin type to a pretty name, fall back
                  // to the name from sabre if no mapping exists though
                  Text(_getCabinLabel(passenger.cabin)),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ..._buildGroupCodeWidget(),
                        Text("Seat ${passenger.seatNumber ?? '--'}")
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildRemarksWidget() {
    if (passenger.remarks == null || passenger.remarks.isEmpty)
      return [];

    return [
      bulletDivider,
      Text(
        passenger.remarks,
        style: priorityCodeTextStyle,
      ),
    ];
  }

  List<Widget> _buildGroupCodeWidget() {
    if (passenger.groupNumber == null || passenger.groupNumber.isEmpty)
      return [];

    return [
      Text(passenger.groupNumber),
      lightBulletDivider,
    ];
  }

  List<Widget> _buildSeatAssignedIcon() {
    if (!_isSeatAssignedIndicatorNeeded())
      return [];

    return [
      Padding(
        padding: const EdgeInsets.only(left: AaeDimens.baseUnit),
        child: Icon(
            AaeIconsv4.checkMark,
            size: 20,
            color: const Color(0xff008712)
        ),
      )
    ];
  }

  static _buildBulletDivider(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          color: color,
        ),
        width: 3.0,
        height: 3.0,
      ),
    );
  }

  bool _isSeatAssignedIndicatorNeeded() {
    if (type != PriorityPassengerListType.REVENUE_STANDBY &&
        type != PriorityPassengerListType.NONREV_STANDBY)
      return false;

    return passenger.seatNumber != null && passenger.seatNumber.isNotEmpty;
  }

  String _getCabinLabel(String sabreCabinCode) {
    if (sabreCabinCode == null)
      return "";
    else if (cabinLabels.containsKey(sabreCabinCode))
      return cabinLabels[passenger.cabin];
    else return sabreCabinCode;
  }
}
