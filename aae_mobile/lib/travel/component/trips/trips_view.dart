import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/trips/tools_widget.dart';
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
    return _buildTripsContainer(context);
  }

  Widget _buildTripsContainer(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: Column(
      children: <Widget>[
        TripsWidget(viewModel: this.viewModel),
        ToolsWidget(),
      ],
    ));
  }
}
