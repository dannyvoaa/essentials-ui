import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/model/check_in_passenger.dart';
import 'package:aae/model/check_in_request.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:aae/travel/component/checkin/widgets/checkin_segment_details.dart';
import 'package:aae/travel/component/checkin/widgets/checkin_segment_traveler_select.dart';
import 'package:aae/travel/component/checkin/widgets/checkin_commit_button.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';

import 'checkin_confirm_card.dart';

class CheckInNavButton extends StatelessWidget {
  final CheckInViewModel viewModel;

  CheckInNavButton({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:16,bottom:16,left:20,right:20,),
      child: ButtonTheme(
        minWidth: 260.0,
        height: 46.0,
        child: RaisedButton(
          textColor: Colors.white,
          color: AaeColors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0),),
          onPressed: () {
            print('Check in button a res detail page pressed...');
            showAsModalBottomSheet(viewModel: viewModel, context: context);
          },
          child: Text('Check in', style:AaeTextStyles.btn18),
        ),
      ),
    );
  }

  /// Displays the Hazardous Material Notice in a modal bottom sheet overlaying
  /// the user interface.
  static showAsModalBottomSheet({
    @required CheckInViewModel viewModel,
    @required BuildContext context,
  }) {
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
            child: ConfirmCard(viewModel: viewModel),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ));
  }
}