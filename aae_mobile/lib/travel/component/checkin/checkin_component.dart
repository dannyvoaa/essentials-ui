import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/travel/component/checkin/checkin_view.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/theme/colors.dart';

import 'package:aae/travel/component/checkin/checkin_bloc.dart';

class CheckInArguments{
  final String pnr;
  final BuiltList<ReservationDetailPassenger> passengers;

  CheckInArguments({
    @required this.pnr,
    @required this.passengers,
  });
}

/// Ties together [CheckInBloc] and [CheckInView].
class CheckInComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<CheckInBloc, CheckInBlocFactory>(
      bloc: (factory) => factory.checkInBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<CheckInViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            return Container(
              child: CheckInView(viewModel: snapshot.value),
            );
          },
        );
      },
    );
  }
}