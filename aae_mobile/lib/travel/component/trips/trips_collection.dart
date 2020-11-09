import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/trips/trips_list_widget.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

class TripsCollection extends StatelessWidget {
  TripsCollection({this.viewModel, this.header, this.loadReservationDetail});

  final TripsViewModel viewModel;
  final String header;
  final Function(BuildContext, String) loadReservationDetail;

  @override
  Widget build(BuildContext context) {
    return _buildTripsCollection(context);
  }

  _buildTripsCollection(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                header,
                style: TextStyle(
                  fontSize: 15,
                  color: AaeColors.blue,
                  fontWeight: FontWeight.w700,
                  height: 2.6666666666666665,
                ),
                textAlign: TextAlign.left,
              ),
            )),
        TripsListWidget(viewModel: this.viewModel, loadReservationDetail: loadReservationDetail,)
      ],
    ));
  }
}
