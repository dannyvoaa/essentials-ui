import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:aae/common/widgets/stats_bar/stats_bar.dart';

/// A app bar for the news feed page.
class NewsFeedTopBar extends StatelessWidget implements PreferredSizeWidget {
  static final _elevation = 00.0;

  // Definition for this partially taken from that of app_bar.dart
  @override
  final preferredSize = Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    //TODO(rpaglinawan): make drop shadow on app bar
    return AppBar(
      centerTitle: false,
      title: TopBarTitle('Good Morning, Juan Carlos'),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0293FF),
              Color(0xFF0078D2),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 9.0),
                  child: Icon(
                    AaeIcons.notifications,
                    color: AaeColors.white,
                    size: 11,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 7.0),
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 14,
                      color: AaeColors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 9.0),
                  child: Icon(
                    AaeIcons.calendar,
                    color: AaeColors.white,
                    size: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigateCommand(routes.buildRouteName(
                        tab: routes.calendar,
                        pageWidgetRoute: routes.calendar))(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 7.0),
                    child: Text(
                      'Events',
                      style: TextStyle(
                        fontSize: 14,
                        color: AaeColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StatsBar(),
          ],
        ),
      ),
      elevation: _elevation,
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
