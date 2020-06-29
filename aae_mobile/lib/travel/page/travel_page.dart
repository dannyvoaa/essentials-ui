import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/home/component/news_feed_list_item/news_feed_list_item_view.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/recognition/component/points_balance/points_balance_component.dart';
import 'package:aae/recognition/component/points_history/points_history_component.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/trips/trips_list_widget.dart';
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
              TripsComponent(),
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
