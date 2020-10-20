import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:get/get.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:expandable/expandable.dart';

class TripsExpPanel extends StatelessWidget {
  const TripsExpPanel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
//      padding: EdgeInsets.all(20),
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
      child: Column(
        children: <Widget>[
          DepartureStatus(),
          RouteInfo(),
          LocatorInfo(),
        ],
      ),
    );
  }
}

class RouteInfo extends StatelessWidget {
  const RouteInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ExpandableTheme(
        data: ExpandableThemeData(
          iconColor: AaeColors.ultraLightGray,
          animationDuration: const Duration(milliseconds: 100),
          iconRotationAngle: 1.55,
//              iconSize: 24,
          hasIcon: true,
          tapBodyToExpand: true,
          expandIcon: Icons.arrow_forward_ios,
          collapseIcon: Icons.arrow_forward_ios,
        ),
        child: Container(
          child: ExpandablePanel(
            header: RouteSummary(),
            expanded: RouteDetails(),
//            collapsed: _routeDetails(context),
          ),
        ),
      ),
    );
  }
}

class RouteSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 80,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RouteSummaryColumn('11:15 AM', 'DFW'),
          Icon(Icons.arrow_forward_sharp),
          RouteSummaryColumn('1:20 PM', 'MAD'),
        ],
      ),
    );
  }
}

class RouteSummaryColumn extends StatelessWidget {
  final String time;
  final String location;

  RouteSummaryColumn(this.time, this.location);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time),
        Text(location),
      ],
    );
  }
}

Widget _routeDetails(BuildContext context) {
  // backing data
  final items = ['Test01', 'Test02', 'Test03', 'Test04'];

  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Container(
        height: 80,
        width: 80,
        child: Text(item),
      );
//      return ListTile(
////        title: item.buildTitle(context),
//        title: Text(item),
//      );
    },
  );
}

class RouteDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RouteDetail('Dallas/Fort Worth International Airport (DFW)',
            '12hr 5min', true, 'Main', 'Airbus A321', true),
        RouteDetail('Dallas/Fort Worth International Airport (DFW)',
            '12hr 5min', true, 'Main', 'Airbus A321', true),
        Text('Madrid-Barajas Adolfo Suarez Airport (MAD)'),
      ],
    );
  }
}

class RouteDetail extends StatelessWidget {
  final String hub;
  final String duration;
  final bool overnight;
  final String cabin;
  final String equipment;
  final bool wifi;
  const RouteDetail(this.hub, this.duration, this.overnight, this.cabin,
      this.equipment, this.wifi);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 14,
            width: 14,
            padding: EdgeInsets.only(top:20),
            decoration: BoxDecoration(
              border: Border.all(
                color: AaeColors.blue,
                width: 2,
              ),
              color: AaeColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: OverflowBox(
                minWidth: 0.0,
                maxWidth: 2.0,
                minHeight: 0.0,
                maxHeight: 10.0,
                child: Container(
                  height:20,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(
            width:10,
          ),
          Column(
            children: [
              Text(hub),
              Row(
                children: [
                  Text(duration),
                  Text(String.fromCharCode(0x2022)),
                  overnight
                      ? Text('Overnight' + String.fromCharCode(0x2022))
                      : null,
                  Text(cabin),
                  Text(String.fromCharCode(0x2022)),
                  Text(equipment),
                  wifi ? Text(String.fromCharCode(0x2022)) : null,
                  wifi ? Icon(Icons.wifi) : null,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Locator information band at the bottom of the expanded view widget

class LocatorInfo extends StatelessWidget {
  const LocatorInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AaeColors.bgLightGray,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          LocatorColumn('LOCATOR', 'XDSSWP', CrossAxisAlignment.start),
          LocatorColumn('GATE', '25', CrossAxisAlignment.center),
          LocatorColumn('TERMINAL', 'C', CrossAxisAlignment.center),
          LocatorColumn('SEAT', '18A', CrossAxisAlignment.end),
        ],
      ),
    );
  }
}

class LocatorColumn extends StatelessWidget {
  final String heading;
  final String content;
  final alignment;

  LocatorColumn(this.heading, this.content, this.alignment);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: alignment,
      children: [
        Text(
          heading,
          style: AaeTextStyles.locatorInfoHeading,
        ),
        Text(
          content,
          style: AaeTextStyles.locatorInfo,
        ),
      ],
    );
  }
}

class DepartureStatus extends StatelessWidget {
  const DepartureStatus({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.all(20);
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('1234 Departs in 1 hr 33 min'),
          Text('ONTIME'),
        ],
      ),
    );
  }
}
