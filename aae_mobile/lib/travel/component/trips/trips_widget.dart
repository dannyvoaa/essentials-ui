import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/d0_stats_bar/component/d0_stats_bar_component.dart';
import 'package:aae/home/component/news_feed_top_bar/top_bar_title_component.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/tools_widget.dart';
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
    return SizedBox(height: 200, child: _buildTripsWidget(context));
  }

  _buildTripsWidget(BuildContext context) {
    return Container(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              width: 380,
              child: Text(
                'Upcoming trips',
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
            Expanded(
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: viewModel.trips.length,
                    separatorBuilder: (_, __) {
                      return Container(
                        height: AaeDimens.smallCardVerticalContentPadding,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                            title: Row(children: <Widget>[
                          Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${viewModel.trips[index].pnrDescription}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans',
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
                                  '${viewModel.trips[index].pnr}',
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans',
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
                                child: Icon(Icons.arrow_forward_ios)),
                          )
                        ])
//                          title: Text(
//                            '${viewModel.trips[index].pnrDescription}',
//                            style: TextStyle(
//                              fontFamily: 'AmericanSans',
//                              fontSize: 18,
//                              color: const Color(0xff36495a),
//                            ),
//                            textAlign: TextAlign.left,
//                          ),
//                          trailing: Wrap( spacing: 12,
//                          children: <Widget>[
//                          Text(
//                            '${viewModel.trips[index].pnr}',
//                            style: TextStyle(
//                              fontFamily: 'AmericanSans',
//                              fontSize: 15,
//                              color: const Color(0xff627a88),
//                            ),
//                            textAlign: TextAlign.right,
//                          ),
//                              Icon(Icons.arrow_forward_ios)
//                            ]
//                          )
//                          //Text('${viewModel.trips[index].pnr}'),
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
                      );
                    }),
            )
          ],
        ));
  }
}
