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
class AaeTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  static final _elevation = 00.0;

  // Definition for this partially taken from that of app_bar.dart
  @override
  final preferredSize = Size.fromHeight(54);

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
          title: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Calendar',
              style: AaeTextStyles.title20WhiteMed,
            ),
          ),
          gradient: AaeColors.appBarGradient,
        ),
      ),
    );
  }
}


