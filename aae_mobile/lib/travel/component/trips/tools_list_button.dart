import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/d0_stats_bar/component/d0_stats_bar_component.dart';
import 'package:aae/home/component/news_feed_top_bar/top_bar_title_component.dart';
import 'package:aae/model/pnrs.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

/// A app bar for the news feed page.
class ToolsListButton<T> extends StatelessWidget {
  ToolsListButton({this.iconData, this.title, this.subtitle});

  final IconData iconData;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return _buildToolsListButton(context);
  }

  _buildToolsListButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            bottom: AaeDimens.smallCardVerticalContentPadding),
        child: Container(
          child: ListTile(
              title: Row(children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(iconData, size: 30, color: const Color(0xff0078d2))),
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
                                  '$title',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans Medium',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: const Color(0xff36495a),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  '$subtitle',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: const Color(0xff627a88),
                                  ),
                                ),
                              )
                            ]))),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios, color: AaeColors.ultraLightGray)),
                )
              ])),
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
        ));
  }
}
