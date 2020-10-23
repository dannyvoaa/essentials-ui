import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/travel/component/priority_list/priority_list_component.dart';
import 'package:aae/travel/component/trips/trips_component.dart';
import 'package:aae/travel/component/travel_top_bar/travel_top_bar.dart';
import 'package:flutter/material.dart';

class TravelPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        endDrawer: AaeDrawer(),
        appBar: TravelTopBar(),
        body: Container(
          child: TabBarView(
            children: <Widget>[
              TripsComponent(),
              PriorityListComponent(),
              TripsComponent(),
            ],
          ),
          color: const Color(0xfff5f7f7),
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
