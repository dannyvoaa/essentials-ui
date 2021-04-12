import 'package:aae/common/widgets/button/large_button.dart';
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
  final Function(BuildContext, String, bool) loadBoardingPasses;

  ReservationView({
    this.viewModel,
    this.loadBoardingPasses,
  });

  bool _boardingPassAvailable() {
    var segments = viewModel.reservationDetail.segments;
    if (segments.asList().any((element) => element.passengerInfo.asList().any((e) => e.checkedIn == true))) {
      return true;
    }
    return false;
  }

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
                  separatorBuilder: (BuildContext context, int index) => StopDivider(index: index, viewModel: viewModel),
                  itemBuilder: (context, index) {
                    return TripDetailExpandPanel(
                      index: index,
                      viewModel: viewModel,
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: double.infinity,
                child: LargeButton.primary(
                  boolEnabled: true,
                  stringTitle: 'Check in',
                  onTapAction: () {
                    Navigator.of(context).pushNamed(
                      '/checkin',
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
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: double.infinity,
                child: LargeButton.primary(
                  boolEnabled: _boardingPassAvailable(),
                  stringTitle: 'Boarding pass',
                  onTapAction: () => loadBoardingPasses(context, this.viewModel.reservationDetail.recordLocator, true),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
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
