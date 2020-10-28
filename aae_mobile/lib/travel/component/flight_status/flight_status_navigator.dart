import 'package:aae/travel/component/search/search.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:aae/travel/component/flight_status/flight_status_component.dart';

import '../../../programmatic_main.dart';
import 'flight_status_details.dart';

class FlightStatusNavigator extends StatelessWidget {
  static final _log = Logger('FlightStatusNavigator');

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => Search(
                calendarLength: 5,
                searchType1: cityAirportSearch,
                searchType2: flightNumberSearch,
                title: 'Flight status');
            break;
          case '/second':
            builder = (BuildContext _) => FlightStatusDetails(model: null);
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

  void Function() cityAirportSearch(
      BuildContext context, String data1, String data2, String searchDate) {
    print('cityAirportSearch()');
    print(data1);
    print(data2);
    Navigator.pushNamed(context, '/second');
  }

  void Function() flightNumberSearch(
      BuildContext context, String data1, String data2, String searchDate) {
    print('flightNumberSearch()');
    print(data1);
    print(data2);
    print(searchDate);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightStatusComponent(
            searchField1: data1, searchField2: data2, searchDate: searchDate),
      ),
    );
  }
}
