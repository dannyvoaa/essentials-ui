import 'package:aae/assets/aae_icons.dart';
import 'package:aae/travel/component/flight_status/flight_status_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:intl/intl.dart';

class FlightStatusCard extends StatelessWidget {
  const FlightStatusCard({
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
          FlightStatusCardHeader(viewModel: this.viewModel),
          FlightStatusCardBody(viewModel: viewModel),
          FlightStatusCardFooter(viewModel: this.viewModel),
        ],
      ),
    );
  }
}

class FlightStatusCardHeader extends StatelessWidget {
  FlightStatusCardHeader({
    Key key,
    this.viewModel,
  }) : super(key: key);
  final FlightStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.only(left: 0, right: 15, bottom: 15);
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
              Text('${viewModel.flightStatus.flightNumber}',
                  style: AaeTextStyles.departureHeading),
            ],
          ),
          Text(
            '${viewModel.flightStatus.status.toUpperCase()}',
            style: calculateStatusColor(
                viewModel.flightStatus.status.toUpperCase()),
          ),
        ],
      ),
    );
  }

  TextStyle calculateStatusColor(String status) {
    switch (status) {
      case "DELAYED":
        {
          return AaeTextStyles.departureDelayed;
        }

      case "CANCELLED":
        {
          return AaeTextStyles.departureCancelled;
        }

      default:
        {
          return AaeTextStyles.departureOnTime;
        }
    }
  }
}

class FlightStatusCardBody extends StatelessWidget {
  const FlightStatusCardBody({this.viewModel});

  final FlightStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, bottom: 15),
      child: Row(
        children: [
          FlightStatusCardBodyColumn(
              '${formatDate(viewModel.flightStatus.originInfo.estimatedTime)}',
              '${viewModel.flightStatus.originInfo.airportCode}',
              '${formatDate(viewModel.flightStatus.originInfo.scheduledTime)}',
              true),
          FlightStatusCardBodyColumn(
              '${formatDate(viewModel.flightStatus.destinationInfo.estimatedTime)}',
              '${viewModel.flightStatus.destinationInfo.airportCode}',
              '${formatDate(viewModel.flightStatus.destinationInfo.scheduledTime)}',
              false),
        ],
      ),
    );
  }

  String formatDate(String time) {
    if (time.isNotEmpty) {
      DateTime dateTime = DateTime.parse(time);
      String formattedDate = DateFormat('h:mm a').format(dateTime);
      return formattedDate;
    } else {
      return time;
    }
  }
}

class FlightStatusCardBodyColumn extends StatelessWidget {
  String time;
  String location;
  String scheduledTime;
  bool arrowIcon;

  FlightStatusCardBodyColumn(
      this.time, this.location, this.scheduledTime, this.arrowIcon);

  @override
  Widget build(BuildContext context) {
    if (this.time == null || this.time == '') {
      time = this.scheduledTime;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Row(children: [
            Text(
              time,
              style: AaeTextStyles.timeSummary,
            ),
            _buildArrowIcon(arrowIcon),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            location,
            style: AaeTextStyles.reservationSubHeading,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            'Scheduled: ' + scheduledTime,
            style: TextStyle(color: AaeColors.lightGrayText),
          ),
        ),
      ],
    );
  }

  Widget _buildArrowIcon(bool arrowIcon) {
    if (arrowIcon) {
      return Container(
        alignment: Alignment.topCenter,
        height: 18,
        padding: EdgeInsets.only(top: 0, left: 35, right: 35),
        child: Icon(
          AaeIconsv4.arrow_forward,
          color: AaeColors.gray,
        ),
      );
    } else {
      return Container();
    }
  }
}

class FlightStatusCardFooter extends StatelessWidget {
  const FlightStatusCardFooter({
    Key key,
    this.viewModel,
  }) : super(key: key);
  final FlightStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AaeColors.backgroundLightGray,
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          LocatorColumn(
              'BOARDING',
              '${formatBoardingTime(viewModel.flightStatus.originInfo.estimatedTime)}',
              CrossAxisAlignment.start),
          LocatorColumn(
              'GATE',
              '${isValueNull(viewModel.flightStatus.originInfo.gate)}',
              CrossAxisAlignment.center),
          LocatorColumn(
              'TERMINAL',
              '${isValueNull(viewModel.flightStatus.originInfo.terminal)}',
              CrossAxisAlignment.center),
          LocatorColumn(
              'BAGGAGE',
              '${isValueNull(viewModel.flightStatus.baggageClaimArea)}',
              CrossAxisAlignment.end),
        ],
      ),
    );
  }

  String formatBoardingTime(String time) {
    if (time == null || time == '') {
      time = this.viewModel.flightStatus.originInfo.scheduledTime;
    }
    if (time.isNotEmpty) {
      DateTime dateTime = DateTime.parse(time);
      DateTime newDateTime = dateTime.subtract(new Duration(minutes: 30));
      String formattedDate = DateFormat('h:mm a').format(newDateTime);
      return formattedDate;
    } else {
      return time;
    }
  }

  String isValueNull(String value) {
    if (value == null || value == '') {
      value = '--';
    }
    return value;
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
        Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: Text(
            heading,
            style: AaeTextStyles.locatorInfoHeading,
          ),
        ),
        Text(
          content,
          style: AaeTextStyles.locatorInfo,
        ),
      ],
    );
  }
}
