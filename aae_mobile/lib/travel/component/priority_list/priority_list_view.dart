
import 'package:aae/travel/component/priority_list/results/priority_list_flight_inventory_card.dart';
import 'package:aae/travel/component/priority_list/results/priority_list_footer.dart';
import 'package:aae/travel/component/priority_list/results/priority_passenger_list.dart';
import 'package:aae/travel/component/priority_list/results/priority_list_header.dart';
import 'package:flutter/material.dart';

import 'priority_list_view_model.dart';

/// The widget that displays the priority list for a given flight.
class PriorityListView extends StatelessWidget {
  final PriorityListViewModel viewModel;

  final ScrollController _scroller = ScrollController();

  PriorityListView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        controller: _scroller,
        children: [
          PriorityListHeader(this.viewModel),
          PriorityListFlightInventory(this.viewModel),
          ... _buildPassengerLists(),
          PriorityListFooter(
            onUpButtonClicked: scrollUp,
          ),
        ],
      ),
    );
  }

  /// Builds the passenger list sections that display priority order,
  /// checked in information, etc.
  List<PriorityPassengerList> _buildPassengerLists() {
    List<PriorityPassengerList> passengerLists = [];

    PriorityPassengerListType.values.forEach((listType) {
      passengerLists.add(PriorityPassengerList(
        viewModel: this.viewModel,
        type: listType,
      ));
    });

    return passengerLists;
  }

  void scrollUp() {
    _scroller.animateTo(
      _scroller.position.minScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
