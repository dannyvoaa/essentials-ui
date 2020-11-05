import 'package:aae/travel/component/search/search.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_component.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class PriorityListNavigator extends StatelessWidget {
  static final _log = Logger('PriorityListView');

  final GlobalKey<NavigatorState> nestedNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await nestedNavKey.currentState.maybePop(),
      child: Navigator(
        key: nestedNavKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          ReservationDetailArguments args = settings.arguments;

          switch (settings.name) {
            case '/':
              builder = (_) => Search(
                title: "Priority List",
                calendarLength: 5,
                searchType2: loadReservationDetail,
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
      ),
    );
  }

  void loadReservationDetail(BuildContext context, String pnr) {
    _log.info("loadPriorityList(pnr: '$pnr')");

    Navigator.of(context).pushNamed(
      '/results',
      arguments: ReservationDetailArguments(
        pnr: pnr,
//        origin: origin,
//        flightNumber: int.parse(flightNumber),
//        departureDate: DateTime.parse(departureDate),
      ),
    );
  }
}
