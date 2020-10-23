import 'package:aae/assets/aae_icons.dart';
import 'package:aae/model/priority_list_cabin.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/priority_list/results/priority_list_flight_inventory_card.dart';
import 'package:aae/travel/component/priority_list/results/priority_passenger_list.dart';
import 'package:aae/travel/component/priority_list/results/priority_list_header.dart';
import 'package:flutter/material.dart';

import '../priority_list_view_model.dart';

/// The widget that displays the priority list for a given flight.
///
/// ...
class PriorityListResults extends StatelessWidget {
  final PriorityListViewModel viewModel;

  final ScrollController _scroller = ScrollController();

  /// ...
  PriorityListResults(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        controller: _scroller,
        children: [
          PriorityListHeader(this.viewModel),
          PriorityListFlightInventory(this.viewModel),
          Column(
            children: _buildPassengerLists(),
          ),
          _buildScrollUpButton()
        ],
      ),
    );
  }

  /// Builds the passenger list sections that actually have data in them.
  List<PriorityPassengerList> _buildPassengerLists() {
    List<PriorityPassengerList> passengerLists = [];

    PriorityPassengerListType.values.forEach((listType) {
      var listHasMembers = true;

      if (listHasMembers) {
        passengerLists.add(PriorityPassengerList(
          viewModel: this.viewModel,
          type: listType,
        ));
      }
    });

    return passengerLists;
  }

  Widget _buildScrollUpButton() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 40,
            padding: EdgeInsets.only(right:AaeDimens.baseUnit),
            child: FlatButton(
              padding: EdgeInsets.all(0.0),
              child: Icon(
                  AaeIconsv4.upArrow,
                  size: 20,
                  color: AaeColors.lightGray
              ),
              onPressed: () {
                _scroller.animateTo(
                  _scroller.position.minScrollExtent,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
