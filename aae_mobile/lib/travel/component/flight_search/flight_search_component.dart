import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/ui/travel_snack_bar.dart';
import 'package:flutter/material.dart';
import 'flight_search_bloc.dart';
import 'flight_search_view.dart';
import 'flight_search_view_model.dart';

class FlightSearchComponent extends StatelessWidget {
  final String destination;
  final String origin;
  final String date;
  final Function(BuildContext, String, String, String) searchType;
  final TravelSnackBar travelSnackBar = new TravelSnackBar();

  FlightSearchComponent(
      {this.destination, this.origin, this.date, this.searchType});

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
                  AaeColors.darkRed,
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

class FlightSearch2Component extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  final String destination;
  final String origin;
  final String date;
  final Function(BuildContext, String, String, String) searchType;
  final TravelSnackBar travelSnackBar = new TravelSnackBar();

  FlightSearch2Component(
      {this.destination, this.origin, this.date, this.searchType});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(
          destination: this.destination,
          origin: this.origin,
          date: this.date,
          searchType: this.searchType),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget(
      {Key key,
      String destination,
      String origin,
      String date,
      Function(BuildContext p1, String p2, String p3, String p4) searchType})
      : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Data Loaded',
  );

  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
          future: _calculation, // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

          }),
    );
  }
}
