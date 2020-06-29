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
class TripsButton<T> extends StatelessWidget {
  TripsButton({this.pnr, this.context});

  final Pnrs pnr;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return _buildTripsButton(context);
  }

  _buildTripsButton(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 5,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${pnr.description}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                color: const Color(0xff36495a),
              ),
              textAlign: TextAlign.left,
            ),
          )),
      Expanded(
        flex: 2,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${pnr.recordLocator}',
              style: TextStyle(
                fontSize: 15,
                color: const Color(0xff627a88),
              ),
              textAlign: TextAlign.right,
            )),
      ),
      Expanded(
        flex: 1,
        child: Align(
            alignment: Alignment.centerRight,
            child:
                Icon(Icons.arrow_forward_ios, color: AaeColors.ultraLightGray)),
      )
    ]);
  }
}
