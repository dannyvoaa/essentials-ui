import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/d0_stats_bar/component/d0_stats_bar_component.dart';
import 'package:aae/home/component/news_feed_top_bar/top_bar_title_component.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/travel_list_tile/travel_full_button.dart';
import 'package:aae/travel/component/trips/tools_list_button.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

/// A app bar for the news feed page.
class ToolsListWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final preferredSize = Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return _buildToolsListWidget(context);
  }

  _buildToolsListWidget(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                'Tools',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color(0xff0078d2),
                  fontWeight: FontWeight.w700,
                  height: 2.6666666666666665,
                ),
                textAlign: TextAlign.left,
              ),
            )),
        TravelListTile(
          buttonContent: ToolsListButton(
              iconData: Icons.list,
              title: 'Priority list',
              subtitle: 'Look up available and assigned seats.'),
        ),
        TravelListTile(
          buttonContent: ToolsListButton(
              iconData: Icons.access_time,
              title: 'Flight status',
              subtitle: 'Get arrival and departure information.'),
        ),
      ],
    ));
  }
}
