import 'package:aae/travel/component/priority_list/priority_list_component.dart';
import 'package:aae/travel/component/priority_list/results/dummy_search_panel.dart';
import 'package:aae/travel/component/priority_list/results/priority_list_results.dart';
import 'package:aae/travel/component/search/search.dart';
import 'package:aae/travel/component/search/search_form.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'priority_list_view_model.dart';

class PriorityListView extends StatelessWidget {
  static final _log = Logger('PriorityListView');

  final PriorityListViewModel viewModel;
  final GlobalKey<NavigatorState> nestedNavKey = GlobalKey<NavigatorState>();

  PriorityListView({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await nestedNavKey.currentState.maybePop(),
      child: Navigator(
        key: nestedNavKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (_) => Search(
                title: "Priority List",
                calendarLength: 5,
                searchType2: loadPriorityList,
              );
              break;
            case '/results':
              builder = (_) => PriorityListResults(viewModel: this.viewModel);
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }

  void loadPriorityList(BuildContext context, String flightNum, String origin, String searchDate) {
    _log.info("loadPriorityList(origin: '$origin', flightNum: '$flightNum', searchDate:'$searchDate')");

    Navigator.of(context).pushNamed('/results');
    viewModel.loadPriorityList(origin, int.parse(flightNum), DateTime.parse(searchDate));

    _log.info("loadPriorityList COMPLETE");
  }
}
