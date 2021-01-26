import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/travel_list_tile/travel_full_button.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter/material.dart';

class ToolsList extends StatelessWidget {
  static const String header = 'Tools';

  @override
  Widget build(BuildContext context) {
    return _buildTripsCollection(context);
  }

  _buildTripsCollection(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text(
                header,
                style: AaeTextStyles.subtitle15BlueBold,
                textAlign: TextAlign.left,
              ),
            )),
        _buildToolsListWidget(context)
      ],
    ));
  }

  _buildToolsListWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        TravelListTile(
          buttonContent: ToolsButton(
              iconData: AmericanIconsv4_6.list,
              title: 'Priority list',
              subtitle: 'See available and assigned seats for this flight.'),
        ),
        TravelListTile(
          buttonContent: ToolsButton(
              iconData: AmericanIconsv4_6.notifications,
              title: 'Create travel notifications',
              subtitle: 'Create text or email notification for this flight.'),
        ),
      ],
    );
  }
}

class ToolsButton extends StatelessWidget {
  ToolsButton({this.iconData, this.title, this.subtitle});

  final IconData iconData;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return _buildToolsButton(context);
  }

  _buildToolsButton(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 1,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  height: 30,
                  width: 30,
                  child: Icon(iconData, size: 30, color: AaeColors.blue)))),
      Expanded(
          flex: 6,
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Text(
                    '$title',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'AmericanSansMedium',
                      fontSize: 16,
                      color: AaeColors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    '$subtitle',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13,
                      color: AaeColors.gray,
                    ),
                  ),
                )
              ]))),
    ]);
  }
}
