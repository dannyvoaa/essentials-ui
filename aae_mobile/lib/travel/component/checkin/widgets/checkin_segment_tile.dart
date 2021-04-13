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

import 'checkin_nav_button.dart';

class CheckInSegmentTile extends StatelessWidget {

  final CheckInViewModel viewModel;
  final int index;

  CheckInSegmentTile({
    this.index,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context){
    final _formKey = GlobalKey<FormState>();
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29131313),
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            CheckInSegmentDetails(index: index, viewModel: viewModel),
            CheckInTravelerSelect(viewModel: viewModel),
            CheckInNavButton(
              viewModel: viewModel,
//              pnr: viewModel.
//              onClicked: buildCheckinRequest,
            ),
          ],
        ),
      ),
    );
  }
}
