import 'package:aae/model/priority_list_cabin.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/travel_list_tile/travel_full_button.dart';
import 'package:flutter/material.dart';

import '../priority_list_view_model.dart';

class PriorityListFlightInventory extends StatelessWidget {
  static const labelMap = {
    "PREMIUM": "Premium",
    "FIRST": "First",
    "BUSINESS": "Business",
    "PREMIUM_COACH": "PE",
    "PREMIUMECONOMY": "PE",
    "MAIN": "Main",
    "COACH": "Main"
  };

  final PriorityListViewModel viewModel;

  PriorityListFlightInventory(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AaeDimens.baseUnit,
        right: AaeDimens.baseUnit,
        bottom:  AaeDimens.baseUnit * 0.5,
      ),
      child: TravelListTile(
        buttonContent: DefaultTextStyle(
          style: TextStyle(
            fontFamily: 'AmericanSans',
            fontSize: 18,
            color: const Color(0xff627a88),
          ),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            columnWidths: {0: IntrinsicColumnWidth()},
            children: _buildTableRows(),
          ),
        ),
      ),
    );
  }

  List<TableRow> _buildTableRows() {
    List<Widget> labels = [_buildCell("")];
    List<Widget> capacity = [_buildCell("Capacity", centered: false)];
    List<Widget> confirmed = [_buildCell("Confirmed", centered: false)];
    List<Widget> assigned = [_buildCell("Assigned", centered: false)];
    List<Widget> unassigned = [_buildCell("Unassigned", centered: false)];

    for (PriorityListCabin cabin in viewModel.priorityList.cabins) {
      if (labelMap.containsKey(cabin.cabinType))
        labels.add(_buildHeaderCell(labelMap[cabin.cabinType]));
      else
        labels.add(_buildHeaderCell(cabin.cabinType));

      capacity.add(_buildCell((cabin.assignedSeats + cabin.unassignedSeats).toString()));
      confirmed.add(_buildCell(cabin.confirmedSeats.toString()));
      assigned.add(_buildCell(cabin.assignedSeats.toString()));
      unassigned.add(_buildCell(cabin.unassignedSeats.toString()));
    }

    return [
      _buildRow(labels),
      _buildRow(capacity),
      _buildRow(confirmed),
      _buildRow(assigned),
      _buildRow(unassigned, includeDivider: false),
    ];
  }

  TableRow _buildRow(List<Widget> fields, {bool includeDivider = true}) {
    return TableRow(
        children: fields,
        decoration: BoxDecoration(
          border: !includeDivider ? null : Border(
            bottom: BorderSide(
                width: 0.5, color: const Color(0x82707070),
            ),
          ),
        ),
    );
  }

  Widget _buildCell(String text, {bool centered = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(text,softWrap: false,
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: Text(text,
        softWrap: false,
        textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'AmericanSans',
            fontSize: viewModel.priorityList.cabins.length >= 4 ? 14 : 18,
            color: const Color(0xff627a88),
          ),
      ),
    );
  }
}
