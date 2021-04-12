import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/travel/component/ui/travel_snack_bar.dart';
import 'package:flutter/material.dart';

import 'international_details_view_model.dart';
import 'international_details_bloc.dart';
import 'international_details_view.dart';

class InternationalDetailsArgs{
  final String pnr;
  final int travelerIndex;

  InternationalDetailsArgs({this.pnr, this.travelerIndex = 0});
}

/// Ties together [InternationalDetailsBloc] and [InternationalDetailsView].
class InternationalDetailsComponent extends StatelessWidget {
  final TravelSnackBar travelSnackBar = new TravelSnackBar();
  final String pnr;
  final int travelerIndex;

  final Function(BuildContext, String) onCompleted;

  InternationalDetailsComponent({@required this.pnr, this.travelerIndex = 0, this.onCompleted});

  InternationalDetailsComponent.from(InternationalDetailsArgs args, {onCompleted})
      : this.pnr = args.pnr,
        this.travelerIndex = args.travelerIndex,
        this.onCompleted = onCompleted;

  static routeTo(BuildContext context, {String pnr, int travelerIndex = 0}) {
    Navigator.of(context).pushNamed(
      "/internationalDetails",
      arguments: InternationalDetailsArgs(
        pnr: pnr,
        travelerIndex: travelerIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Component<InternationalDetailsBloc, InternationalDetailsBlocFactory>(
      bloc: (factory) => factory.checkinIntlDetailsBloc(),
      builder: (context, bloc) {
        // initiate our back end call if needed
        bloc.loadPassengerDetails(pnr, travelerIndex);

        // and build our view
        return SourceBuilder.of<InternationalDetailsViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present && snapshot.value != null &&
                snapshot.value.passenger != null) {
              return InternationalDetailsView(
                viewModel: snapshot.value,
                onCompleted: this.onCompleted,
              );
            } else {
              return Center(child: AaeLoadingSpinner());
            }
          },
        );
      },
    );
  }
}
