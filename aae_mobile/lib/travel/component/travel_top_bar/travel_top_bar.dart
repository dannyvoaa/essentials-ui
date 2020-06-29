import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

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
    )),
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
    return Container(
      child: Container(
        child: GradientAppBar(
          centerTitle: false,
          title: Align(
              alignment: Alignment.bottomLeft,
              heightFactor: 3,
              child: Text(
                'Travel',
                style: TextStyle(color: AaeColors.white),
              )),
          gradient: AaeColors.appBarGradient,
          bottom: PreferredSize(
            preferredSize: preferredSize,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabs: tabs,
                isScrollable: true,
                indicatorColor: AaeColors.orange,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
