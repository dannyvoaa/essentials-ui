import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
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

class RouteInfo extends StatelessWidget {
  const RouteInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
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
          header: Container(child: Text('test')),
//            collapsed: Text('test collapsed', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
          expanded: Text(
            'test expanded',
            softWrap: true,
          ),
        ),
      ),
//            ExpandablePanel(
//              header: Text('test'),
////            collapsed: Text('test collapsed', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
//              expanded: Text('test expanded', softWrap: true, ),
//              tapHeaderToExpand: true,
//              hasIcon: true,
//            ),
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
