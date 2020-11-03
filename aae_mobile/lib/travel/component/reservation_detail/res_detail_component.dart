import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:flutter/material.dart';

import 'package:aae/travel/component/reservation_detail/res_detail_bloc.dart';

class ReservationDetailArguments{
  final String origin;
  final int flightNumber;
  final DateTime departureDate;

  ReservationDetailArguments({
    @required this.origin,
    @required this.flightNumber,
    @required this.departureDate
  });
}

/// Ties together [PriorityListBloc] and [PriorityListView].
class ReservationDetailComponent extends StatelessWidget {
  final String origin;
  final int flightNumber;
  final DateTime departureDate;

  ReservationDetailComponent({
    @required this.origin,
    @required this.flightNumber,
    @required this.departureDate
  });

  ReservationDetailComponent.from(ReservationDetailArguments args):
        this.origin = args.origin,
        this.flightNumber = args.flightNumber,
        this.departureDate = args.departureDate;


  @override
  Widget build(BuildContext context) {
    return Component<ReservationDetailBloc, ResDetailBlocFactory>(
      bloc: (factory) => factory.resDetailBloc(),
      builder: (context, bloc) {
        // initiate our back end call
        bloc.loadPriorityList(origin, flightNumber, departureDate);

        // and build our view
        return SourceBuilder.of<PriorityListViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present && snapshot.value != null && snapshot.value.priorityList != null) {
              return PriorityListView(viewModel: snapshot.value);
            } else {
              return Center(child: AaeLoadingSpinner());
            }
          },
        );
      },
    );
  }
}
