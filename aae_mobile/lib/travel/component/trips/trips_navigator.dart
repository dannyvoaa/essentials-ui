import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_component.dart';

class TripsNavigator extends StatelessWidget {
  static final _log = Logger('ReservationDetailView');

  TripsNavigator({this.nestedNavKey, this.refreshTopBar});

  final GlobalKey<NavigatorState> nestedNavKey;
  final Function(BuildContext context) refreshTopBar;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: nestedNavKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        ReservationDetailArguments args = settings.arguments;
        switch (settings.name) {
          case '/':
            builder = (_) => TripsComponent(
                  loadReservationDetail: loadReservationDetail,
                );
            break;
          case '/results':
            builder = (_) => ReservationDetailComponent.from(args);
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

  void loadReservationDetail(BuildContext context, String pnr) {
    _log.info("loadReservationDetail(pnr: '$pnr')");

    Navigator.of(context).pushNamed(
      '/results',
      arguments: ReservationDetailArguments(
        pnr: pnr,
      ),
    );
    refreshTopBar(context);
  }
}
