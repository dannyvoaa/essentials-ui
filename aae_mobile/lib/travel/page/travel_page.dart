import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/home/component/news_feed_list_item/news_feed_list_item_view.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/recognition/component/points_balance/points_balance_component.dart';
import 'package:aae/recognition/component/points_history/points_history_component.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/trips/trips.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:aae/travel/component/travel_top_bar/travel_top_bar.dart';
import 'package:flutter/material.dart';

import '../travel_component.dart';

class TravelPage extends StatelessWidget {
  final List<Tab> tabs = <Tab>[
    Tab(
      child: Text(
        'Trips',
        style: TextStyle(color: AaeColors.white),
      ),
    ),
    Tab(
        child: Text(
      'Priority list',
      style: TextStyle(color: AaeColors.white),
    )),
    Tab(
      child: Text(
        'Flight status',
        style: TextStyle(color: AaeColors.white),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        endDrawer: AaeDrawer(),
        appBar: TravelTopBar(),
//        appBar: AppBar(
//          iconTheme: new IconThemeData(color: Colors.grey),
//          backgroundColor: AaeColors.blue,
//          elevation: AaeDimens.noElevation,
//          actions: <Widget>[],
//          bottom: TabBar(tabs: tabs),
//        ),
        body: TabBarView(
          children: <Widget>[
            TripsComponent(),
            TripsComponent(),
            TripsComponent(),
          ],
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
