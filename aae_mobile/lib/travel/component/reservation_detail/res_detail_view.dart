import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_cancel_slider.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_divider.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_exp_panel.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_passenger_panel.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_summary_title.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';

class ReservationView extends StatelessWidget {
  final ReservationDetailViewModel viewModel;

  ReservationView({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTripsContainer(context);
  }

  Widget _buildTripsContainer(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: TripSummaryTitle(viewModel: viewModel),
              ),
              Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.reservationDetail.segments.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      StopDivider(index: index, viewModel: viewModel),
                  itemBuilder: (context, index) {
                    return TripDetailExpandPanel(
                      index: index,
                      viewModel: viewModel,
                    );
                  },
                ),
              ),
              Container(
                child: TripsPassengerPanel(
                  viewModel: viewModel,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:16),
                child: TripsCollection(viewModel: null, header: 'Tools'),
              ),
              Container(
                child: CancelSlider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
