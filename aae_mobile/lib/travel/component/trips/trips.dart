//import 'package:aae/assets/aae_icons.dart';
//import 'package:aae/common/commands/navigate_command.dart';
//import 'package:aae/d0_stats_bar/component/d0_stats_bar_component.dart';
//import 'package:aae/home/component/news_feed_top_bar/top_bar_title_component.dart';
//import 'package:aae/navigation/routes.dart' as routes;
//import 'package:aae/theme/colors.dart';
//import 'package:aae/theme/dimensions.dart';
//import 'package:aae/theme/typography.dart';
//import 'package:flutter/material.dart';
//
///// A app bar for the news feed page.
//class Trips extends StatelessWidget implements PreferredSizeWidget {
//
//  static final _elevation = 00.0;
//  final List<Tab> tabs = <Tab>[
//    Tab(
//      child: Text(
//        'Trips',
//        style: TextStyle(color: AaeColors.white),
//      ),
//    ),
//    Tab(
//        child: Text(
//          'Priority list',
//          style: TextStyle(color: AaeColors.white),
//        )
//    ),
//    Tab(
//      child: Text(
//        'Flight status',
//        style: TextStyle(color: AaeColors.white),
//      ),
//    ),
//  ];
//
//  // Definition for this partially taken from that of app_bar.dart
//  @override
//  final preferredSize = Size.fromHeight(108);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.all(AaeDimens.baseUnit),
//      child: Container(
//        decoration: BoxDecoration(
//            color: AaeColors.white,
//            borderRadius: BorderRadius.all(
//                Radius.circular(AaeDimens.currentBalanceCardRadius))),
//        height: AaeDimens.currentBalanceCardHeight,
//        width: AaeDimens.contentWidth,
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//              padding:
//              const EdgeInsets.all(AaeDimens.currentBalanceCardSpacing),
//              child: Text(
//                'Current balance:',
//                style: TextStyle(fontSize: 18),
//              ),
//            ),
//            Center(
//              child: Padding(
//                padding: const EdgeInsets.only(
//                    top: AaeDimens.currentBalanceCardTopMargin),
//                child: Text(
//                  'points',
//                  style: TextStyle(
//                      fontSize: 50,
//                      color: AaeColors.recognitionGreen,
//                      fontWeight: FontWeight.w800),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
//
////class TopBarTitle extends StatelessWidget {
////  final String text;
////
////  TopBarTitle(this.text);
////
////  @override
////  Widget build(BuildContext context) {
////    return Text(
////      text,
////      textAlign: TextAlign.left,
////      style: AaeTextStyles.h5,
////    );
////  }
//// }
