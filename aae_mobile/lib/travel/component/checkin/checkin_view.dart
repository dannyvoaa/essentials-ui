import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/checkin/widgets/checkin_segments.dart';
import 'package:aae/travel/component/checkin/widgets/checkin_summary_title.dart';

class CheckInView extends StatelessWidget {
  final CheckInViewModel viewModel;

  CheckInView({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTripsContainer(context);
  }

  Widget _buildTripsContainer(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: CheckInSummaryTitle(viewModel: viewModel),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Check In',
                    style: TextStyle(
                      fontSize: 15,
                      color: AaeColors.blue,
                      fontWeight: FontWeight.w700,
                      height: 2.6666666666666665,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                child: CheckInSegments(viewModel: viewModel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
