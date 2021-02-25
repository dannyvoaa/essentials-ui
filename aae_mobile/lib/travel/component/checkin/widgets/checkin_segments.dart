import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:aae/travel/component/checkin/widgets/checkin_segment_tile.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';

class CheckInSegments extends StatelessWidget {
  const CheckInSegments({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CheckInViewModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.reservationDetail.segments.length,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height:16),
        itemBuilder: (context, index) {
          return CheckInSegmentTile(
            index: index,
            viewModel: viewModel,
          );
        },
      ),
//      child: CheckInSegmentTile(viewModel: viewModel,),
    );
  }
}


