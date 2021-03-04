import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/travel_list_tile/travel_full_button.dart';
import 'package:aae/travel/component/trips/tools_button.dart';
import 'package:aae/travel/component/trips/trips_button.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

class TripsListWidget extends StatelessWidget {
  TripsListWidget({this.viewModel, this.loadReservationDetail});

  final TripsViewModel viewModel;
  final Function(BuildContext, String) loadReservationDetail;

  @override
  Widget build(BuildContext context) {
    if (this.viewModel == null) {
      return _buildToolsListWidget(context);
    } else {
      return _buildTripsListWidget(context);
    }
  }

  _buildTripsListWidget(BuildContext context) {
    return SizedBox(
      height: 82.00 * viewModel.pnrs.length,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: viewModel.pnrs.length,
          itemBuilder: (context, index) {
            return TravelListTile(
              buttonContent: InkWell(
                onTap: () {
                  print('tapped...');
                  loadReservationDetail(
                      context, this.viewModel.pnrs[index].recordLocator);
                },
                child: TripsButton(
                    pnr: this.viewModel.pnrs[index], context: context),
              ),
            );
          }),
    );
  }

  _buildToolsListWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        TravelListTile(
          buttonContent: ToolsButton(
              iconData: AmericanIconsv4_6.list,
              title: 'Priority list',
              subtitle: 'Look up available and assigned seats.'),
        ),
        TravelListTile(
          buttonContent: ToolsButton(
              iconData: AmericanIconsv4_6.clock,
              title: 'Flight status',
              subtitle: 'Get arrival and departure information.'),
        ),
      ],
    );
  }
}
