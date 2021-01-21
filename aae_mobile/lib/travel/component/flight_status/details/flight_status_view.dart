import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/flight_status/details/widgets/flight_status_card.dart';
import 'package:aae/travel/component/ui/tools_list_widget.dart';
import 'package:flutter/material.dart';
import 'flight_status_view_model.dart';

class FlightStatusView extends StatelessWidget {
  final FlightStatusViewModel viewModel;

  FlightStatusView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          children: [
            _buildHeader(),
            FlightStatusCard(viewModel: viewModel),
            ToolsList(),
          ],
        ),
      ),
    ));
  }

  _buildHeader() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Flight status',
            style: AaeTextStyles.subtitle15,
            textAlign: TextAlign.left,
          ),
        ));
  }
}
