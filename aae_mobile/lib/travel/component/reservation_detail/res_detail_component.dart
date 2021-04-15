import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_bloc.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:aae/travel/component/ui/travel_snack_bar.dart';
import 'package:flutter/material.dart';

class ReservationDetailArguments {
  final String pnr;

  ReservationDetailArguments({
    @required this.pnr,
  });
}

/// Ties together [ReservationDetailBloc] and [ReservationView].
class ReservationDetailComponent extends StatelessWidget {
  final String pnr;
  final Function(BuildContext, String, bool) loadBoardingPasses;
  final TravelSnackBar travelSnackBar = new TravelSnackBar();

  ReservationDetailComponent(
      {@required this.pnr, this.loadBoardingPasses});

  ReservationDetailComponent.from(ReservationDetailArguments args,
      {loadBoardingPasses, showSnackBar})
      : this.pnr = args.pnr,
        this.loadBoardingPasses = loadBoardingPasses;

  @override
  Widget build(BuildContext context) {
    return Component<ReservationDetailBloc, ReservationDetailBlocFactory>(
      bloc: (factory) => factory.reservationDetailBloc(),
      builder: (context, bloc) {
        /// initiate our back end call
        bloc.loadReservationDetail(pnr);

        /// and build our view
        return SourceBuilder.of<ReservationDetailViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present && snapshot.value != null) {
              if (snapshot.value.cancelReservationStatus == 'FAIL') {
                travelSnackBar.showSnackBar(
                    context,
                    'Trip could not be cancelled. Please try again.',
                    AaeColors.orange,
                    false);
              } else if (snapshot.value.cancelReservationStatus == 'SUCCESS') {
                String tripName = snapshot.value.reservationDetail.description;
                travelSnackBar.showSnackBar(context, '$tripName has been cancelled.',
                    AaeColors.green, true);
              } else if (snapshot.value.cancelReservationStatus == 'LOADING') {
                return Center(child: AaeLoadingSpinner());
              }
            }
            if (snapshot.present &&
                snapshot.value != null &&
                snapshot.value.reservationDetail != null) {
              return ReservationView(
                  viewModel: snapshot.value,
                  loadBoardingPasses: loadBoardingPasses,
                  cancelReservation: bloc.cancelReservation);
            } else {
              return Center(child: AaeLoadingSpinner());
            }
          },
        );
      },
    );
  }
}