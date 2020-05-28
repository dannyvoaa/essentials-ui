import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/d0_stats_bar/component/d0_stats_bar_component.dart';
import 'package:aae/home/component/news_feed_top_bar/top_bar_title_component.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

/// A app bar for the news feed page.
class NewsFeedTopBar extends StatelessWidget implements PreferredSizeWidget {
  static final _elevation = 00.0;

  // Definition for this partially taken from that of app_bar.dart
  @override
  final preferredSize = Size.fromHeight(86);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
//        decoration: BoxDecoration(
//          boxShadow: [
//            BoxShadow(
//              color: AaeColors.lightGray,
//              blurRadius: 5.0,
//              spreadRadius: 1.0,
//              offset: Offset(
//                0.0,
//                0.0,
//              ),
//            ),
//          ],
//        ),
        child: GradientAppBar(
          centerTitle: false,
//      backgroundColor: AaeColors.lightOrange,
          title: TopBarTitleComponent(),
          gradient: AaeColors.appBarGradient,
//      flexibleSpace: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.topLeft,
//            end: Alignment.bottomRight,
//            colors: [
//              Color(0xFF0293FF),
//              Color(0xFF0078D2),
//            ],
//          ),
//        ),
//      ),
          bottom: PreferredSize(
            preferredSize: preferredSize,
            child: Column(
              children: <Widget>[
//            Row(
//              children: <Widget>[
//                GestureDetector(
//                  onTap: () {
//                    navigateCommand(routes.buildRouteName(
//                        tab: routes.notifications,
//                        pageWidgetRoute: routes.notifications))(context);
//                  },
//                  child: Row(
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.only(left: 20, bottom: 9.0),
//                        child: Icon(
//                          AaeIcons.notifications,
//                          color: AaeColors.white,
//                          size: 11,
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(left: 10.0, bottom: 7.0),
//                        child: Text(
//                          'Notifications',
//                          style: TextStyle(
//                            fontSize: 14,
//                            color: AaeColors.white,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                GestureDetector(
//                  onTap: () {
//                    navigateCommand(routes.buildRouteName(
//                        tab: routes.events,
//                        pageWidgetRoute: routes.events))(context);
//                  },
//                  child: Row(
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.only(left: 20, bottom: 9.0),
//                        child: Icon(
//                          AaeIcons.calendar,
//                          color: AaeColors.white,
//                          size: 14,
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(left: 10.0, bottom: 7.0),
//                        child: Text(
//                          'Events',
//                          style: TextStyle(
//                            fontSize: 14,
//                            color: AaeColors.white,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            ),
                D0StatsComponent(),
              ],
            ),
          ),
          elevation: _elevation,
        ),
      ),
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
