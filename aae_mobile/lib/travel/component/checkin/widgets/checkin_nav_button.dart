import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:aae/travel/component/international_details/international_details_component.dart';
import 'package:flutter/material.dart';

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
            InternationalDetailsComponent.routeTo(context,
              pnr: viewModel.reservationDetail.recordLocator,
            );
          },
          child: Text('Check in', style:AaeTextStyles.btn18),
        ),
      ),
    );
  }
}