import 'package:aae/travel/component/flight_search/flight_search_component.dart';
import 'package:aae/travel/component/search/search.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'details/flight_status_view.dart';
import 'package:aae/travel/component/flight_status/details/flight_status_component.dart';

class FlightStatusNavigator extends StatelessWidget {
  static final _log = Logger('FlightStatusNavigator');
  final GlobalKey<NavigatorState> nestedNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return !await nestedNavKey.currentState.maybePop();
        },
        child: Navigator(
          initialRoute: '/',
          key: nestedNavKey,
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => Search(
                    calendarLength: 3,
                    searchType1: cityAirportSearch,
                    searchType2: flightNumberSearch,
                    title: 'Flight status');
//                builder = (BuildContext _) =>
//                    FlightSearchComponent(
//                    destination: 'LAX',
//                    origin: 'DFW',
//                    date: '2020-11-21');
//                builder = (BuildContext _) => FlightStatusComponent(
//                    flightNumber: '2459',
//                    origin: 'DFW',
//                    date: '2020-11-21');
                break;
              case '/second':
                builder = (BuildContext _) => FlightStatusView(viewModel: null);
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }

  void cityAirportSearch(
      BuildContext context, String data1, String data2, String searchDate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightSearchComponent(
            destination: data1.toUpperCase(),
            origin: data2.toUpperCase(),
            date: searchDate,
            searchType: flightNumberSearch),
      ),
    );
  }

  void flightNumberSearch(
      BuildContext context, String data1, String data2, String searchDate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightStatusComponent(
            flightNumber: data1, origin: data2, date: searchDate),
      ),
    );
  }
}
