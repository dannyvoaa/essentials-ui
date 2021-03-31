import 'package:aae/travel/component/boarding_pass/boarding_pass_component.dart';
import 'package:aae/travel/component/checkin/checkin_component.dart';
import 'package:aae/travel/component/hazmat/hazmat_component.dart';
import 'package:aae/travel/component/international_details/international_details_component.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_component.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

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
        switch (settings.name) {
          case '/':
            builder = (_) => TripsComponent(
                  loadReservationDetail: loadReservationDetail,
                );
            break;
          case '/results':
            ReservationDetailArguments args = settings.arguments;
            builder = (_) => ReservationDetailComponent.from(args);
            break;
          case '/checkin':
            builder = (_) => CheckInComponent();
            break;
          case '/internationalDetails':
            InternationalDetailsArgs args = settings.arguments;
            builder = (_) => InternationalDetailsComponent.from(
              args,
              onCompleted: onInternationalDetailsComplete,
            );
            break;
          case '/boardingpass':
            builder = (_) => BoardingPassComponent();
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

    Navigator.of(context)
        .pushNamed(
          '/results',
          arguments: ReservationDetailArguments(
            pnr: pnr,
          ),
        )
        .then((value) => refreshTopBar(context));
    refreshTopBar(context);
  }

  void onInternationalDetailsComplete(BuildContext context) {
    HazmatComponent.showAsModalBottomSheet(
      context,
      onAgreeButtonClicked: () {
        Navigator.of(context).pushNamed('/boardingpass');
      }
    );
  }
}
