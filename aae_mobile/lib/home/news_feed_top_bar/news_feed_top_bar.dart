import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/d0_stats_bar/component/d0_stats_bar_component.dart';
import 'package:aae/home/news_feed_top_bar/top_bar_title_component.dart';
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
//      height:200,
      child: Container(
        child: GradientAppBar(
        automaticallyImplyLeading: false,
          centerTitle: false,
          title: TopBarTitleComponent(),
          gradient: AaeColors.newsAppBarGradient,
          bottom: PreferredSize(
            preferredSize: preferredSize,
            child: Column(
              children: <Widget>[
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
