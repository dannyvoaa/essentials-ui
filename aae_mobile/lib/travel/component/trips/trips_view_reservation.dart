import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'trips_view_model.dart';

class TripsReservation extends StatelessWidget {
//  final TripsReservationModel viewModel;
//
//  TripsView({
//    @required this.viewModel,
//  });

  @override
  Widget build(BuildContext context) {
    return _buildTripsContainer(context);
  }

  Widget _buildTripsContainer(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //?
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('test'),
                Text('test'),
              ],
            )),
        padding: const EdgeInsets.all(16.0));
  }
}