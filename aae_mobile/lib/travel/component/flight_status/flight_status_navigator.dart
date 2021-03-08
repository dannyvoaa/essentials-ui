import 'package:aae/home/news_feed_page.dart';
import 'package:aae/travel/component/flight_search/flight_search_component.dart';
import 'package:aae/travel/component/search/search.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'details/flight_status_view.dart';
import 'package:aae/travel/component/flight_status/details/flight_status_component.dart';

class FlightStatusNavigator extends StatelessWidget {
  FlightStatusNavigator({this.nestedNavKey, this.refreshTopBar});

  static final _log = Logger('FlightStatusNavigator');
  final GlobalKey<NavigatorState> nestedNavKey;
  final Function(BuildContext context) refreshTopBar;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: nestedNavKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => Search(
                calendarLength: 3,
                searchType1: cityAirportSearch,
                searchType2: flightNumberSearch,
                title: 'Flight status');
            break;
          case '/flightStatusDetails':
            builder = (_) => FlightStatusComponent.from(settings.arguments);
            refreshTopBar(context);
            break;
          case '/searchResults':
            builder = (_) => FlightSearchComponent.from(settings.arguments);
            refreshTopBar(context);
            break;
//                builder = (BuildContext _) =>
//                    FlightSearchComponent(
//                    destination: 'LAX',
//                    origin: 'DFW',
//                    date: '2020-11-21');
//                builder = (BuildContext _) => FlightStatusComponent(
//                    flightNumber: '2459',
//                    origin: 'DFW',
//                    date: '2020-11-21');
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

  void cityAirportSearch(
      BuildContext context, String data1, String data2, String searchDate) {
    Navigator.of(context)
        .pushNamed(
          '/searchResults',
          arguments: FlightSearchArguments(
              destination: data1.toUpperCase(),
              origin: data2.toUpperCase(),
              date: searchDate,
              searchType: flightNumberSearch),
        )
        .then((value) => refreshTopBar(context));
    refreshTopBar(context);
  }

  void flightNumberSearch(
      BuildContext context, String data1, String data2, String searchDate) {
    Navigator.of(context).pushNamed(
      '/flightStatusDetails',
      arguments: FlightStatusArguments(
        origin: data2,
        flightNumber: data1,
        date: searchDate,
      ),
    ).then((value) => refreshTopBar(context));
    refreshTopBar(context);
  }
}
