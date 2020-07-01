import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/travel_list_tile/travel_full_button.dart';
import 'package:aae/travel/component/trips/tools_button.dart';
import 'package:aae/travel/component/trips/trips_button.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

class TripsListWidget extends StatelessWidget {
  TripsListWidget({this.viewModel});

  final TripsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (this.viewModel == null) {
      return _buildToolsListWidget(context);
    } else if(this.viewModel.pnrs.length > 0) {
      return _buildTripsListWidget(context);
    } else {
      return _buildNoTripsCollection(context);
    }
  }

  _buildTripsListWidget(BuildContext context) {
    return SizedBox(
        height: 68.00 * viewModel.pnrs.length,
        child: Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: viewModel.pnrs.length,
              itemBuilder: (context, index) {
                return TravelListTile(
                  buttonContent: TripsButton(
                      pnr: this.viewModel.pnrs[index], context: context),
                );
              }),
        ));
  }

  _buildNoTripsCollection(BuildContext context) {
    return TravelListTile(
        buttonContent: Row(children: <Widget>[
      Expanded(
          flex: 5,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'There are no upcoming trips.',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: AaeColors.black,
              ),
              textAlign: TextAlign.left,
            ),
          )),
    ]));
  }

  _buildToolsListWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        TravelListTile(
          buttonContent: ToolsButton(
              iconData: AaeIconsv4.list,
              title: 'Priority list',
              subtitle: 'Look up available and assigned seats.'),
        ),
        TravelListTile(
          buttonContent: ToolsButton(
              iconData: AaeIconsv4.clock,
              title: 'Flight status',
              subtitle: 'Get arrival and departure information.'),
        ),
      ],
    );
  }
}
