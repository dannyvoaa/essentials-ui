import 'package:aae/travel/component/priority_list/priority_list_component.dart';
import 'package:aae/travel/component/priority_list/results/dummy_search_panel.dart';
import 'package:aae/travel/component/search/search.dart';
import 'package:aae/travel/component/search/search_form.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'priority_list_view_model.dart';

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
          PriorityListArguments args = settings.arguments;

          switch (settings.name) {
            case '/':
              builder = (_) => Search(
                    title: "Priority List",
                    calendarLength: 5,
                    searchType2: loadPriorityList,
                  );
              break;
            case '/results':
              builder = (_) => PriorityListComponent.from(args);
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }

          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }

  void loadPriorityList(BuildContext context, String flightNumber, String origin, String departureDate) {
    _log.info("loadPriorityList(origin: '$origin', flightNumber: '$flightNumber', departureDate:'$departureDate')");

    Navigator.of(context).pushNamed(
      '/results',
      arguments: PriorityListArguments(
        origin: origin,
        flightNumber: int.parse(flightNumber),
        departureDate: DateTime.parse(departureDate),
      ),
    );
  }
}
