import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/travel/component/checkin/checkin_bloc.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:aae/travel/component/ui/travel_snack_bar.dart';
import 'package:flutter/material.dart';

import 'hazmat_view.dart';

/// Ties together [CheckInViewModel] and [HazmatView].
class HazmatComponent extends StatelessWidget {
  final TravelSnackBar travelSnackBar = new TravelSnackBar();
  final Function onAgreeButtonClicked;

  HazmatComponent({this.onAgreeButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Component<CheckInBloc, CheckInBlocFactory>(
      bloc: (factory) => factory.checkInBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<CheckInViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present && snapshot.value != null) {
              return HazmatView(
                viewModel: snapshot.value,
                onAgreeButtonClicked: this.onAgreeButtonClicked,
              );
            } else {
              return Center(child: AaeLoadingSpinner());
            }
          },
        );
      },
    );
  }

  /// Displays the Hazardous Material Notice in a modal bottom sheet overlaying
  /// the user interface.
  static showAsModalBottomSheet(BuildContext context, {Function onAgreeButtonClicked}) {
    showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        //barrierColor: Color(0x01000000),
        builder: (_) => FractionallySizedBox(
          heightFactor: 0.90,
          child: Padding(
            padding: EdgeInsets.only(
            ),
            child: HazmatComponent(onAgreeButtonClicked: onAgreeButtonClicked,),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ));
  }
}