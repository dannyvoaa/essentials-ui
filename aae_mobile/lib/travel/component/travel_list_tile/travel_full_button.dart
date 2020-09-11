import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/d0_stats_bar/component/d0_stats_bar_component.dart';
import 'package:aae/home/news_feed_top_bar/top_bar_title_component.dart';
import 'package:aae/model/pnr.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

/// A app bar for the news feed page.
class TravelListTile<T> extends StatelessWidget {
  TravelListTile({this.buttonContent});

  final Widget buttonContent;

  @override
  Widget build(BuildContext context) {
    return _buildTravelListTile(context);
  }

  _buildTravelListTile(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            bottom: AaeDimens.smallCardVerticalContentPadding),
        child: InkWell(
          onTap: (){},
          child: Container(
            child: ListTile(
              title: buttonContent,
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
          ),
        ));
  }
}
