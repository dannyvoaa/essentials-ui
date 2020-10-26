import 'package:aae/assets/aae_icons.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/travel/component/flight_status/flight_status_view_model.dart';
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

class FlightStatusExpPanel extends StatelessWidget {
  const FlightStatusExpPanel({
    Key key,
    this.viewModel,
  }) : super(key: key);
  final FlightStatusViewModel viewModel;

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
          DepartureStatus(viewModel: this.viewModel),
          RouteInfo(viewModel: this.viewModel),
          LocatorInfo(viewModel: this.viewModel),
        ],
      ),
    );
  }
}

class RouteInfo extends StatelessWidget {
  const RouteInfo({
    Key key,
    this.viewModel,
  }) : super(key: key);
  final FlightStatusViewModel viewModel;

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
            header: RouteSummary(viewModel: viewModel),
            expanded: RouteDetails(),
//            collapsed: _routeDetails(context),
          ),
        ),
      ),
    );
  }
}

class RouteSummary extends StatelessWidget {
  const RouteSummary({this.viewModel});

  final FlightStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 80,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RouteSummaryColumn(
              '${viewModel.flightStatus.originInfo.estimatedTime}',
              '${viewModel.flightStatus.originInfo.airportCode}'),
          Icon(
            Icons.arrow_forward,
            color: AaeColors.gray,
          ),
          RouteSummaryColumn(
              '${viewModel.flightStatus.destinationInfo.estimatedTime}',
              '${viewModel.flightStatus.destinationInfo.airportCode}'),
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
        Text(
          time,
          style: AaeTextStyles.timeSummary,
        ),
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
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
      ),
      child: Column(
        children: <Widget>[
          RouteDetail('Dallas/Fort Worth International Airport (DFW)',
              '12hr 5min', true, 'Main', 'Airbus A321', true),
          RouteDetailEnd('Madrid-Barajas Adolfo Suarez Airport (MAD)'),
        ],
      ),
    );
  }
}

class RouteDetailEnd extends StatelessWidget {
  final String hub;

  const RouteDetailEnd(this.hub);

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
            height: 12,
            width: 12,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: AaeColors.ultraLightGray,
                width: 1,
              ),
              color: AaeColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                  child: Text(hub, style: AaeTextStyles.hubDetailHeading)),
            ],
          ),
        ],
      ),
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
            height: 12,
            width: 12,
            padding: EdgeInsets.only(top: 35),
            decoration: BoxDecoration(
              border: Border.all(
                color: AaeColors.ultraLightGray,
                width: 1,
              ),
              color: AaeColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Align(
//              alignment: const Alignment(0.0, 0.0),
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 1.0,
                height: 40.0,
                child: OverflowBox(
//              minWidth: 0.0,
//              maxWidth: 2.0,
//              minHeight: 0.0,
                  maxHeight: 50.0,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 12,
                    ),
//                    width: 1,
//                    height: double.infinity,
                    color: AaeColors.ultraLightGray,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Text(hub, style: AaeTextStyles.hubDetailHeading)),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      duration,
                      style: AaeTextStyles.routeDetailHeading,
                    ),
                    Text(
                      String.fromCharCode(0x2022),
                      style: AaeTextStyles.dividerDot,
                    ),
                    overnight
                        ? Text(
                            'Overnight',
                            style: AaeTextStyles.routeDetailHeading,
                          )
                        : null,
                    overnight
                        ? Text(
                            String.fromCharCode(0x2022),
                            style: AaeTextStyles.dividerDot,
                          )
                        : null,
                    Text(
                      cabin,
                      style: AaeTextStyles.routeDetailHeading,
                    ),
                    Text(
                      String.fromCharCode(0x2022),
                      style: AaeTextStyles.dividerDot,
                    ),
                    Text(
                      equipment,
                      style: AaeTextStyles.routeDetailHeading,
                    ),
                    wifi
                        ? Text(
                            String.fromCharCode(0x2022),
                            style: AaeTextStyles.dividerDot,
                          )
                        : null,
                    wifi
                        ? Icon(
                            Icons.wifi,
                            color: AaeColors.ultraLightGray,
                            size: 12,
                          )
                        : null,
                  ],
                ),
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
    this.viewModel,
  }) : super(key: key);
  final FlightStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AaeColors.bgLightGray,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          LocatorColumn(
              'BOARDING',
              '${viewModel.flightStatus.originInfo.estimatedTime}',
              CrossAxisAlignment.start),
          LocatorColumn('GATE', '${viewModel.flightStatus.originInfo.gate}',
              CrossAxisAlignment.center),
          LocatorColumn(
              'TERMINAL',
              '${viewModel.flightStatus.originInfo.terminal}',
              CrossAxisAlignment.end),
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
    this.viewModel,
  }) : super(key: key);
  final FlightStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.only(
      left: 0,
      right: 20,
    );
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Image(
                image: AssetImage(
                    'assets/common/american-airlines-eaagle-logo.png'),
                height: 30,
              ),
              Text(
                  '${viewModel.flightStatus.flightNumber} Departs in 1 hr 33 min',
                  style: AaeTextStyles.departureHeading),
            ],
          ),
          Text(
            '${viewModel.flightStatus.status}',
            style: AaeTextStyles.departureOnTime,
          ),
        ],
      ),
    );
  }
}
