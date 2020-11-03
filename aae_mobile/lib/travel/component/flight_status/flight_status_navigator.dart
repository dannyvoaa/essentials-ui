import 'file:///C:/Users/212997/AAProjects/essentials-ui/aae_mobile/lib/travel/component/search/search.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:aae/travel/component/flight_status/flight_status_component.dart';

import '../../../programmatic_main.dart';
import 'flight_status_details.dart';
import 'package:aae/travel/component/search/search.dart';

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
//                builder = (BuildContext _) => FlightStatusComponent(
//                    searchField1: '21',
//                    searchField2: 'data2',
//                    searchDate: '2020-10-30');
                break;
              case '/second':
                builder = (BuildContext _) => FlightStatusDetails(model: null);
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }

  void Function() cityAirportSearch(
      BuildContext context, String data1, String data2, String searchDate) {
    Navigator.pushNamed(context, '/second');
  }

  void Function() flightNumberSearch(
      BuildContext context, String data1, String data2, String searchDate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightStatusComponent(
            searchField1: data1, searchField2: data2, searchDate: searchDate),
      ),
    );
  }
}
