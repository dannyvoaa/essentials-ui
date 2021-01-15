import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
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
    if (this.viewModel == null ||
      return _buildTripsCollection(context);
    } else {
      return Container(width: 0.0, height: 0.0);
    }
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
        TripsListWidget(
          viewModel: this.viewModel,
          loadReservationDetail: loadReservationDetail,
        )
      ],
    ));
  }

  _buildNoTripsCollection(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Container(
                width: 185,
                height: 185,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AaeColors.white),
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Icon(AaeIconsv4.vacation,
                        size: 120, color: AaeColors.darkGray)))),
        Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text('No trips yet...',
                style: AaeTextStyles.reservationNoTripsHeading)),
        Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text('All trips created in Travel Planner',
                style: AaeTextStyles.smallTextStyle)),
        Text('will show up here.', style: AaeTextStyles.smallTextStyle)
      ],
    ));
  }
}
