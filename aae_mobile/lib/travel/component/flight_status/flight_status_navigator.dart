import 'package:aae/travel/component/search/search.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

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
            builder = (BuildContext _) => Search(title: 'Flight status');
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
}
