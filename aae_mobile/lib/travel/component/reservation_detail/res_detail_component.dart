import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_bloc.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:flutter/material.dart';

class ReservationDetailArguments{
  final String pnr;

  ReservationDetailArguments({
    @required this.pnr,
  });
}

/// Ties together [ReservationDetailBloc] and [ReservationView].
class ReservationDetailComponent extends StatelessWidget {
  final String pnr;
  final Function(BuildContext, String, bool) loadBoardingPasses;

  ReservationDetailComponent({
    @required this.pnr,
    this.loadBoardingPasses,
  });

  ReservationDetailComponent.from(ReservationDetailArguments args, {loadBoardingPasses}):
        this.pnr = args.pnr,
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
            if (snapshot.present && snapshot.value != null && snapshot.value.reservationDetail != null) {
              return ReservationView(viewModel: snapshot.value, loadBoardingPasses: loadBoardingPasses);
            } else {
              return Center(child: AaeLoadingSpinner());
            }
          },
        );
      },
    );
  }
}