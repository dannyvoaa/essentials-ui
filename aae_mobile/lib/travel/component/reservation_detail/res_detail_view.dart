import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';

class ReservationView extends StatelessWidget {
  final ReservationDetailViewModel viewModel;

  ReservationView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return _buildReservationContainer(context);
  }

  Widget _buildReservationContainer(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //?
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('testing res view'),
                Text('testing res view'),
//                TripsCollection(viewModel: this.viewModel, header: 'Current trips'),
//                TripsCollection(viewModel: null, header: 'Tools')
              ],
            )),
        padding: const EdgeInsets.all(16.0));
  }
}