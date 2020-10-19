import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/travel/component/search/search.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:flutter/material.dart';

import '../trips/trips_bloc.dart';
import '../trips/trips_view.dart';
import '../trips/trips_view_model.dart';
import 'flight_status_bloc.dart';
import 'flight_status_view.dart';
import 'flight_status_view_model.dart';

/// Ties together [FlightStatusBloc] and [FlightStatusView].
class FlightStatusComponent extends StatelessWidget {

  FlightStatusComponent();

  @override
  Widget build(BuildContext context) {
    return Component<FlightStatusBloc, FlightStatusBlocFactory>(
      bloc: (factory) => factory.flightStatusBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<FlightStatusViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              if (snapshot.value == null) {
                return _buildEmptyState(context);
              } else {
                return FlightStatusView(viewModel: snapshot.value);
              }
            } else {
              return FlightStatusView(viewModel: snapshot.value);
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
