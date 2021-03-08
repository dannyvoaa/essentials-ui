import 'package:aae/travel/component/flight_search/flight_search_component.dart';
import 'package:aae/travel/component/search/search.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'details/priority_list_component.dart';

class PriorityListNavigator extends StatelessWidget {
  PriorityListNavigator({this.nestedNavKey, this.refreshTopBar});

  static final _log = Logger('PriorityListView');

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
            builder = (_) => Search(
                  title: "Priority list",
                  calendarLength: 5,
                  searchType1: cityAirportSearch,
                  searchType2: loadPriorityList,
                );
            break;
          case '/priorityListDetails':
            builder = (_) => PriorityListComponent.from(settings.arguments);
            refreshTopBar(context);
            break;
          case '/searchResults':
            builder = (_) => FlightSearchComponent.from(settings.arguments);
            refreshTopBar(context);
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

  void cityAirportSearch(
      BuildContext context, String data1, String data2, String searchDate) {
    Navigator.of(context).pushNamed(
      '/searchResults',
      arguments: FlightSearchArguments(
          destination: data1.toUpperCase(),
          origin: data2.toUpperCase(),
          date: searchDate,
          searchType: loadPriorityList),
    ).then((value) => refreshTopBar(context));
    refreshTopBar(context);
  }

  void loadPriorityList(BuildContext context, String origin,
      String flightNumber, String departureDate) {
    _log.info(
        "loadPriorityList(origin: '$origin', flightNumber: '$flightNumber', departureDate:'$departureDate')");

    Navigator.of(context).pushNamed(
      '/priorityListDetails',
      arguments: PriorityListArguments(
        origin: origin,
        flightNumber: int.parse(flightNumber),
        departureDate: DateTime.parse(departureDate),
      ),
    ).then((value) => refreshTopBar(context));
    refreshTopBar(context);
  }
}
