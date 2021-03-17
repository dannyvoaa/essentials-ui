import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/boarding_pass/widgets/boarding_pass_list.dart';
import 'package:aae/travel/component/boarding_pass/widgets/boarding_pass_summary_title.dart';
import 'package:aae/travel/component/boarding_pass/widgets/boarding_pass_trip_card.dart';
import 'package:aae/travel/component/reservation_detail/widgets/res_detail_cancel_slider.dart';
import 'package:aae/travel/component/ui/tools_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_view_model.dart';
import 'package:aae/theme/colors.dart';

class BoardingPassView extends StatelessWidget {
  final BoardingPassViewModel viewModel;

  BoardingPassView({
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: BoardingPassSummaryTitle(viewModel: viewModel),
              ),
              Container(
                child: BoardingPassList(viewModel: viewModel,),
                padding: EdgeInsets.only(bottom:12,),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Container(
                      child: BoardingPassTripCard(viewModel: viewModel),
                    ),
                    DepartureNote(),
                    Container(
                      child: ToolsList(),
                    ),
                    Container(
                      child: CancelSlider(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DepartureNote extends StatelessWidget {
  const DepartureNote({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:16,bottom:24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AmericanIconsv4_6.info,
            size: 14,
            color: AaeColors.darkOrange,
          ),
          Container(
            padding: EdgeInsets.only(top:4,left:4,),
            child: Text(
              'Boarding ends 15 minutes before departure.',
              style: AaeTextStyles.body14DarkOrange,
            ),
          ),
        ],
      ),
    );
  }
}
