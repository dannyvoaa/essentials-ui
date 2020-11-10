import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';
import 'flight_search_bloc.dart';
import 'flight_search_view.dart';
import 'flight_search_view_model.dart';

/// Ties together [FlightSearchBloc] and [FlightSearchView].
class FlightSearchComponent extends StatelessWidget {
  final String searchField1;
  final String searchField2;
  final String searchDate;

  FlightSearchComponent(
      {this.searchField1, this.searchField2, this.searchDate});

  @override
  Widget build(BuildContext context) {
    return Component<FlightSearchBloc, FlightSearchBlocFactory>(
      bloc: (factory) => factory.flightSearchBloc(),
      builder: (context, bloc) {
        bloc.loadFlightSearch(
            this.searchField1, this.searchField2, this.searchDate);
        return SourceBuilder.of<FlightSearchViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present &&
                snapshot.value != null &&
                snapshot.value.flightSearch != null) {
              return FlightSearchView(viewModel: snapshot.value);
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
