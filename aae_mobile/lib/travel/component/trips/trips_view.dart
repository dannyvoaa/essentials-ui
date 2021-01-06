import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'trips_view_model.dart';

class TripsView extends StatelessWidget {
  final TripsViewModel viewModel;
  final Function(BuildContext, String) loadReservationDetail;

  TripsView({
    @required this.viewModel,
    this.loadReservationDetail,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTripsContainer(context);
  }

  Widget _buildTripsContainer(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: TripsCollection(
              viewModel: this.viewModel,
              header: 'Current trips',
              loadReservationDetail: loadReservationDetail,
            )
        ),
        padding: const EdgeInsets.all(16.0));
  }
}
