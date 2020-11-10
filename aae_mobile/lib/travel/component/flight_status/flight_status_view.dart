import 'package:flutter/material.dart';
import 'flight_status_details.dart';
import 'flight_status_view_model.dart';

class FlightStatusView extends StatelessWidget {
  final FlightStatusViewModel viewModel;

  FlightStatusView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return _buildFlightStatusContainer(context);
  }

  Widget _buildFlightStatusContainer(BuildContext context) {
    return FlightStatusDetails(viewModel: this.viewModel);
  }
}
