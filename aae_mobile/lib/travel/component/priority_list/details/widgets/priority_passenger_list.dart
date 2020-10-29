import 'package:aae/model/priority_list_passenger.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/priority_list/details/widgets/priority_passenger_list_item.dart';
import 'package:flutter/material.dart';

import '../priority_list_view_model.dart';

enum PriorityPassengerListType {
  REVENUE_OVERSALES,
  REVENUE_UPGRADES,
  REVENUE_STANDBY,
  NONREV_STANDBY
}

class PriorityPassengerList extends StatelessWidget {
  final PriorityListViewModel viewModel;
  final PriorityPassengerListType type;

  static const largeTextStyle = TextStyle(
    fontFamily: 'AmericanSans',
    fontSize: 18,
    color: const Color(0xff36495a),
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

  static const labels = {
    PriorityPassengerListType.REVENUE_OVERSALES: "Confirmed revenue oversales",
    PriorityPassengerListType.REVENUE_UPGRADES: "Confirmed revenue upgrades",
    PriorityPassengerListType.REVENUE_STANDBY: "Revenue standbys",
    PriorityPassengerListType.NONREV_STANDBY: "Non-revenue standbys",
  };

  PriorityPassengerList({this.viewModel, this.type});

  Iterable<PriorityListPassenger> _getPassengers() {
    switch(type) {
      case PriorityPassengerListType.NONREV_STANDBY:
        return viewModel.priorityList.nonrevStandbys;
      case PriorityPassengerListType.REVENUE_OVERSALES:
        return viewModel.priorityList.confirmedRevenueOversales;
      case PriorityPassengerListType.REVENUE_STANDBY:
        return viewModel.priorityList.revenueStandbys;
      case PriorityPassengerListType.REVENUE_UPGRADES:
        return viewModel.priorityList.confirmedRevenueUpgrades;
      default:
        return List();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_getPassengers() == null || _getPassengers().length == 0)
      return Container();

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // header row
          Container(
            padding: EdgeInsets.only(
              top: AaeDimens.baseUnit * 1.5,
              bottom: AaeDimens.baseUnit,
              left: AaeDimens.baseUnit,
              right: AaeDimens.baseUnit,
            ),
            child: Text(
              labels[type],
              style: largeTextStyle,
            ),
          ),

          // passenger rows
          ..._buildPassengerList()
        ],
      ),
    );
  }

  List<PriorityListPassengerListItem> _buildPassengerList() {
    var passengers = _getPassengers();

    List<PriorityListPassengerListItem> passengerList = [];
    for(PriorityListPassenger currPassenger in passengers) {
      passengerList.add(PriorityListPassengerListItem(
        passenger: currPassenger,
        type: this.type,
      ));
    }

    return passengerList;
  }
}
