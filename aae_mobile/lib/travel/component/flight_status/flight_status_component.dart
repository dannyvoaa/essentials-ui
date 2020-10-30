import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';
import 'flight_status_bloc.dart';
import 'flight_status_view.dart';
import 'flight_status_view_model.dart';

/// Ties together [FlightStatusBloc] and [FlightStatusView].
class FlightStatusComponent extends StatelessWidget {
  final String searchField1;
  final String searchField2;
  final String searchDate;

  FlightStatusComponent(
      {this.searchField1, this.searchField2, this.searchDate});

  @override
  Widget build(BuildContext context) {
    return Component<FlightStatusBloc, FlightStatusBlocFactory>(
      bloc: (factory) => factory.flightStatusBloc(),
      builder: (context, bloc) {
        bloc.loadFlightStatus(
            this.searchField1, this.searchField2, this.searchDate);
        return SourceBuilder.of<FlightStatusViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present &&
                snapshot.value != null &&
                snapshot.value.flightStatus != null) {
              return FlightStatusView(viewModel: snapshot.value);
            } else {
              return _buildLoadingState(context);
            }
          },
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(child: AaeLoadingSpinner());
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'Empty',
      ),
    );
  }
}
