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
class TripsWidget extends StatelessWidget implements PreferredSizeWidget {
  TripsWidget({this.viewModel});

  // Definition for this partially taken from that of app_bar.dart
  @override
  final preferredSize = Size.fromHeight(108);
  final TripsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            itemCount: viewModel.trips.length,
            separatorBuilder: (_, __) {
              return Container(
                height: AaeDimens.smallCardVerticalContentPadding,
              );
            },
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AaeDimens.baseUnit),
                child: Container(
                    width: AaeDimens.contentWidth,
                    color: AaeColors.white,
                    child: ListTile(
                      title: Text('${viewModel.trips[index].pnrDescription}'),
                      subtitle: Text('${viewModel.trips[index].pnr}'),
                    )),
              );
            }));
  }
}
