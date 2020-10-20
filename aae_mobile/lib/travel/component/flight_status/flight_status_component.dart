import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/travel/component/search/search.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/repository/travel_repository.dart';

import '../trips/trips_bloc.dart';
import '../trips/trips_view.dart';
import '../trips/trips_view_model.dart';
import 'flight_status_bloc.dart';
import 'flight_status_view.dart';
import 'flight_status_view_model.dart';

/// Ties together [FlightStatusBloc] and [FlightStatusView].
class FlightStatusComponent extends StatelessWidget {
  final String searchField1;
  final String searchField2;

  FlightStatusComponent({this.searchField1, this.searchField2});

  Widget _buildLoadingPageState() {
    return Scaffold(body: Center(child: AaeLoadingSpinner()));
  }

  @override
  Widget build(BuildContext context) {
//    if(this.travelRepository != null){
//      this.travelRepository.fetchFlightStatus('1085', '2020-10-06');
//    }
  print('TESTING SEARCH FIELD');
  print(this.searchField1);
  print(this.searchField2);
    return Component<FlightStatusBloc, FlightStatusBlocFactory>(
      bloc: (factory) => factory.flightStatusBloc(),
      builder: (context, bloc) {
        bloc.fetchFlightStatus(this.searchField1,this.searchField2);
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
              return _buildLoadingPageState();
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
