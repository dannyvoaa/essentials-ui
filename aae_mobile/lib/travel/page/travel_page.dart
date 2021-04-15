import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/home/news_feed_page.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_view.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/priority_list/priority_list_navigator.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:aae/travel/component/trips/trips_navigator.dart';
import 'package:aae/travel/component/travel_top_bar/travel_top_bar.dart';
import 'package:aae/travel/component/flight_status/flight_status_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aae/travel/component/ui/travel_snack_bar.dart';

class TravelPage extends StatefulWidget {
  final GlobalKey<NavigatorState> tripsNestedNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> priorityListNestedNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> flightStatusNestedNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<TravelTopBarState> travelTopBarState =
      GlobalKey<TravelTopBarState>();

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> tabs = <Tab>[
    Tab(
      child: Text(
        'Trips',
        style: TextStyle(color: AaeColors.white100),
      ),
    ),
    Tab(
        child: Text(
      'Priority list',
      style: TextStyle(color: AaeColors.white100),
    )),
    Tab(
      child: Text(
        'Flight status',
        style: TextStyle(color: AaeColors.white100),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    final TravelSnackBar travelSnackBar = new TravelSnackBar();

    SSKeys mykeys = new SSKeys();
    setState(() {});
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: mykeys.scaffoldKeyT,
          endDrawer: AaeDrawer(),
          appBar: TravelTopBar(
              key: widget.travelTopBarState,
              tabs: tabs,
              tabController: _tabController,
              tripsNestedNavKey: widget.tripsNestedNavKey,
              priorityListNestedNavKey: widget.priorityListNestedNavKey,
              flightStatusNestedNavKey: widget.flightStatusNestedNavKey),
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                TripsNavigator(
                    nestedNavKey: widget.tripsNestedNavKey,
                    refreshTopBar: refreshTopBar),
                PriorityListNavigator(
                    nestedNavKey: widget.priorityListNestedNavKey,
                    refreshTopBar: refreshTopBar),
                FlightStatusNavigator(
                    nestedNavKey: widget.flightStatusNestedNavKey,
                    refreshTopBar: refreshTopBar),
              ],
            ),
            color: const Color(0xfff5f7f7),
          ),
        ),
      ),
    );
  }

  refreshTopBar(BuildContext context) {
    if (widget.travelTopBarState != null &&
        widget.travelTopBarState.currentState != null) {
      widget.travelTopBarState.currentState.refreshTopBar(context);
    }
  }
}

class TravelPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => TravelPage();
  }
}
