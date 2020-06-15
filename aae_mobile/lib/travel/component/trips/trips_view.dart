import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/trips/trips_widget.dart';
import 'package:flutter/material.dart';
import 'trips_view_model.dart';

class TripsView extends StatelessWidget {
  final TripsViewModel viewModel;

  TripsView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: _buildTripsContainer(context));
  }

  Widget _buildTripsContainer(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text('Current Trips'),
        TripsWidget(viewModel: this.viewModel),
        Text('Upcoming Trips'),
        TripsWidget(viewModel: this.viewModel),
        Text('Tools'),
        TripsWidget(viewModel: this.viewModel),
      ],
    ));
  }
}
