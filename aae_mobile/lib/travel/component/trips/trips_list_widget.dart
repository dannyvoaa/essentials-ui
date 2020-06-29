import 'package:aae/theme/dimensions.dart';
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
    return _buildTripsListWidget(context);
  }

  _buildTripsListWidget(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 5),
              child: Text(
                'Current trips',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color(0xff0078d2),
                  fontWeight: FontWeight.w700,
                  height: 2.6666666666666665,
                ),
                textAlign: TextAlign.left,
              ),
            )),
        TripsListButton(viewModel: this.viewModel)
      ],
    ));
  }
}
