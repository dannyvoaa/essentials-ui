import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/d0_stats_bar/component/d0_stats_bar_component.dart';
import 'package:aae/home/component/news_feed_top_bar/top_bar_title_component.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

/// A app bar for the news feed page.
class ToolsWidget extends StatelessWidget implements PreferredSizeWidget {
  // Definition for this partially taken from that of app_bar.dart
  @override
  final preferredSize = Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return _buildToolsWidget(context);
  }

  _buildToolsWidget(BuildContext context) {
    return Container(
        width: 380,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              width: 380,
              child: Text(
                'Tools',
                style: TextStyle(
                  fontFamily: 'AmericanSans',
                  fontSize: 15,
                  color: const Color(0xff0078d2),
                  fontWeight: FontWeight.w700,
                  height: 2.6666666666666665,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: AaeDimens.smallCardVerticalContentPadding),
                child: Container(
                  child: ListTile(
                      title: Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.timer)),
                    ),
                    Expanded(
                        flex: 6,
                        child: Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 5.0),
                                child: Text(
                                  'Flight Status',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: const Color(0xff36495a),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'Get arrival and departure information.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans',
                                    fontSize: 15,
                                    color: const Color(0xff627a88),
                                  ),
                                ),
                              )
                            ]))),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_forward_ios)),
                    )
                  ])
//                          leading: Icon(Icons.timer),
//                          title: Text(
//                            'Flight status',
//                            style: TextStyle(
//                              fontFamily: 'AmericanSans',
//                              fontSize: 18,
//                              fontWeight: FontWeight.bold,
//                              color: const Color(0xff36495a),
//                            ),
//                            textAlign: TextAlign.left,
//                          ),
//                          subtitle: Text(
//                            'Get arrival and departure information.',
//                            style: TextStyle(
//                              fontFamily: 'AmericanSans',
//                              fontSize: 15,
//                              color: const Color(0xff627a88),
//                            ),
//                            textAlign: TextAlign.left,
//                          ),
//                          trailing: Icon(Icons.arrow_forward_ios)

                      //Text('${viewModel.trips[index].pnr}'),
                      ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29131313),
                        offset: Offset(0, 2),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: AaeDimens.smallCardVerticalContentPadding),
                child: Container(
                  child: ListTile(
                      title: Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.list)),
                    ),
                    Expanded(
                        flex: 6,
                        child: Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 5.0),
                                  child: Text(
                                    'Priority list',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'AmericanSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: const Color(0xff36495a),
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    'Look up available and assigned seats.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'AmericanSans',
                                      fontSize: 15,
                                      color: const Color(0xff627a88),
                                    ),
                                  )),
                            ]))),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_forward_ios)),
                    )
                  ])
//                          leading: Icon(Icons.timer),
//                          title: Text(
//                            'Flight status',
//                            style: TextStyle(
//                              fontFamily: 'AmericanSans',
//                              fontSize: 18,
//                              fontWeight: FontWeight.bold,
//                              color: const Color(0xff36495a),
//                            ),
//                            textAlign: TextAlign.left,
//                          ),
//                          subtitle: Text(
//                            'Get arrival and departure information.',
//                            style: TextStyle(
//                              fontFamily: 'AmericanSans',
//                              fontSize: 15,
//                              color: const Color(0xff627a88),
//                            ),
//                            textAlign: TextAlign.left,
//                          ),
//                          trailing: Icon(Icons.arrow_forward_ios)

                      //Text('${viewModel.trips[index].pnr}'),
                      ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29131313),
                        offset: Offset(0, 2),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
