import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'flight_status_view_model.dart';
import '../search/date_picker_component.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:aae/travel/component/search/search.dart';

class FlightStatusView extends StatelessWidget {
  final FlightStatusViewModel viewModel;
  final _formKey = GlobalKey<FormState>();

  FlightStatusView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return _buildFlightStatusContainer(context);
  }

  Widget _buildFlightStatusContainer(BuildContext context) {
    DatePickerController _controller = DatePickerController();
    DateTime _selectedValue = DateTime.now();
    bool flightNumberEntered = false;
    bool fromEntered = false;

    return Search();
  }
}
