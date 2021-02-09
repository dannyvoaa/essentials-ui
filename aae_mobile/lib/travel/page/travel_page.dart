import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/home/news_feed_page.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/travel/component/priority_list/priority_list_navigator.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:aae/travel/component/trips/trips_navigator.dart';
import 'package:aae/travel/component/travel_top_bar/travel_top_bar.dart';
import 'package:aae/travel/component/flight_status/flight_status_navigator.dart';
import 'package:flutter/material.dart';


class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {

  @override
  Widget build(BuildContext context) {
    SSKeys mykeys = new SSKeys();
    setState(() {});
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: mykeys.scaffoldKeyT,
          endDrawer: AaeDrawer(),
          appBar: TravelTopBar(),
          body: Container(
            child: TabBarView(
              children: <Widget>[
                TripsNavigator(),
                PriorityListNavigator(),
                FlightStatusNavigator(),
              ],
            ),
            color: const Color(0xfff5f7f7),
          ),
        ),
      ),
    );
  }
}

class TravelPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => TravelPage();
  }
}
