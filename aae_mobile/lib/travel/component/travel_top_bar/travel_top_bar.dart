import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/d0_stats_bar/component/d0_stats_bar_component.dart';
import 'package:aae/home/component/news_feed_top_bar/top_bar_title_component.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

/// A app bar for the news feed page.
class TravelTopBar extends StatelessWidget implements PreferredSizeWidget {

  static final _elevation = 00.0;
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
        )
    ),
    Tab(
      child: Text(
        'Flight status',
        style: TextStyle(color: AaeColors.white),
      ),
    ),
  ];

  // Definition for this partially taken from that of app_bar.dart
  @override
  final preferredSize = Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  PreferredSize(
        child: Align(
          alignment: Alignment.bottomLeft,
          heightFactor: 3,
          child: Text(
          'Travel',
          style: TextStyle(color: AaeColors.white),
          )
        )
      ),
      bottom: PreferredSize(
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            tabs: tabs,
            isScrollable: true,
            indicatorColor: AaeColors.orange,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        )
      )
    );
  }
}

class TopBarTitle extends StatelessWidget {
  final String text;

  TopBarTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: AaeTextStyles.h5,
    );
  }
}
