import 'package:aae/model/flight_status.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/flight_status/flight_status_view_model.dart';
import 'package:aae/travel/component/ui/tools_list_widget.dart';
import 'package:flutter/material.dart';
import 'flight_status_card.dart';

class FlightStatusDetails<T> extends StatelessWidget {

  FlightStatusDetails({this.viewModel, this.context, this.model});

  final BuildContext context;
  final FlightStatus model;
  final FlightStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return _buildFlightStatusDetails2(context);
    } else {
      return _buildEmptyState(context);
    }
  }

  _buildFlightStatusDetails2(context) {
    return Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Flight status",
                    style: TextStyle(
                      fontSize: 15,
                      color: AaeColors.blue,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                child: FlightStatusCard(viewModel: viewModel),
              ),
              Container(
                child: ToolsList(viewModel: null, header: 'Tools'),
              ),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20.0));
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'Empty',
      ),
    );
  }
}
