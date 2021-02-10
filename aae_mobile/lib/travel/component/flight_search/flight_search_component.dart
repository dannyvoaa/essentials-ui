import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/ui/travel_snack_bar.dart';
import 'package:flutter/material.dart';
import 'flight_search_bloc.dart';
import 'flight_search_view.dart';
import 'flight_search_view_model.dart';

class FlightSearchArguments {
  final String destination;
  final String origin;
  final String date;
  final Function(BuildContext, String, String, String) searchType;

  FlightSearchArguments(
      {@required this.destination,
      @required this.origin,
      @required this.date,
      @required this.searchType});
}

class FlightSearchComponent extends StatelessWidget {
  final String destination;
  final String origin;
  final String date;
  final Function(BuildContext, String, String, String) searchType;
  final TravelSnackBar travelSnackBar = new TravelSnackBar();

  FlightSearchComponent(
      {this.destination, this.origin, this.date, this.searchType});

  FlightSearchComponent.from(FlightSearchArguments args)
      : this.destination = args.destination,
        this.origin = args.origin,
        this.date = args.date,
        this.searchType = args.searchType;

  @override
  Widget build(BuildContext context) {
    return Component<FlightSearchBloc, FlightSearchBlocFactory>(
      bloc: (factory) => factory.flightSearchBloc(),
      builder: (context, bloc) {
        bloc.loadFlightSearch(this.destination, this.origin, this.date);
        return SourceBuilder.of<FlightSearchViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present &&
                snapshot.value != null &&
                snapshot.value.flightSearch != null &&
                snapshot.value.flightSearch.flightRoutes != null) {
              return FlightSearchView(
                  viewModel: snapshot.value,
                  searchField1: this.destination,
                  searchField2: this.origin,
                  searchDate: this.date,
                  searchType: searchType);
            } else if (snapshot.present &&
                snapshot.value != null &&
                snapshot.value.flightSearch == null) {
              return _buildLoadingState(context);
            } else {
              travelSnackBar.showSnackBar(
                  context,
                  'No results were found. Please try again.',
                  AaeColors.orange,
                  true);
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
}
