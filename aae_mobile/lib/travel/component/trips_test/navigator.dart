import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:aae/travel/component/trips/trips_view_reservation.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:get/get.dart';
//import 'package:logger/logger.dart';

class TripsNavigator extends StatelessWidget {
//  static final _log = Logger('TripsNavigator');
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/tripsview',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/tripsview':
            builder = (BuildContext _) => TripsComponent();
//            MaterialPageRoute(builder: (_) => TripsComponent());
            break;
          case '/resview':
            builder = (BuildContext _) => TripsReservationView();
//            MaterialPageRoute(builder: (_) => TripsReservationView());
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}