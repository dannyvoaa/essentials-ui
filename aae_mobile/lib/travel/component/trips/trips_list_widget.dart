import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/trips/tools_list_button.dart';
import 'package:aae/travel/component/trips/trips_list_button.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

/// A app bar for the news feed page.
class TripsListWidget extends StatelessWidget implements PreferredSizeWidget {
  TripsListWidget({this.viewModel});

  @override
  final preferredSize = Size.fromHeight(108);
  final TripsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 200, child: _buildTripsListWidget(context));
  }

  _buildTripsListWidget(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Upcoming trips',
            style: TextStyle(
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
                return TripsListButton(
                    pnr: viewModel.trips[index],
                    context: context,
                    index: index);
              }),
        )
      ],
    ));
  }
}
