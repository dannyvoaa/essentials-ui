import 'package:aae/travel/component/travel_list_tile/travel_full_button.dart';
import 'package:aae/travel/component/trips/trips_button.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

/// A app bar for the trips page.
class TripsListButton<T> extends StatelessWidget {
  TripsListButton({this.viewModel});

  final TripsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (this.viewModel.trips.length > 0) {
      return _buildTripsListButton(context);
    } else {
      return _buildNoTripsListWidget(context);
    }
  }

  _buildTripsListButton(BuildContext context) {
    return SizedBox(
        height: 68.00 * viewModel.trips.length,
        child: Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: viewModel.trips.length,
              itemBuilder: (context, index) {
                return TravelListTile(
                  buttonContent: TripsButton(
                      pnr: this.viewModel.trips[index], context: context),
                );
              }),
        ));
  }

  _buildNoTripsListWidget(BuildContext context) {
    return TravelListTile(
        buttonContent: Row(children: <Widget>[
      Expanded(
          flex: 5,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'There are no upcoming trips.',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xff36495a),
              ),
              textAlign: TextAlign.left,
            ),
          )),
    ]));
  }
}
