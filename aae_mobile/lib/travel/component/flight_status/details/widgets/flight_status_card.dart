import 'package:aae/assets/aae_icons.dart';
import 'package:aae/model/flight_status.dart';
import 'package:flutter/material.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:intl/intl.dart';

import '../flight_status_view_model.dart';

class FlightStatusCard extends StatelessWidget {
  const FlightStatusCard({
    Key key,
    this.viewModel,
  }) : super(key: key);
  final FlightStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final FlightStatus flightStatus = this.viewModel.flightStatus;

    return Container(
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
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              FlightStatusCardHeader(flightStatus: flightStatus),
              FlightStatusCardBody(flightStatus: flightStatus),
            ],
          ),
        ));
  }
}

class FlightStatusCardHeader extends StatelessWidget {
  FlightStatusCardHeader({
    Key key,
    this.flightStatus,
  }) : super(key: key);
  final FlightStatus flightStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Container(
                height: 18,
                width: 18,
                padding: EdgeInsets.only(right: 2),
                child: Image.asset(
                  'assets/common/american-airlines-eaagle-logo.png',
                  scale: 20,
                  fit: BoxFit.none,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text('${flightStatus.flightNumber}',
                    style: AaeTextStyles.departureHeading),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(' \u2022', style: AaeTextStyles.departureHeading),
              ),
              Container(
                child: Text(
                    ' ${convertStringToDate(flightStatus.originInfo.scheduledTime)}',
                    style: AaeTextStyles.departureHeading),
              )
            ],
          ),
          Text(
            '${flightStatus.status.toUpperCase()}',
            style: calculateStatusColor(flightStatus.status.toUpperCase()),
          ),
        ],
      ),
    );
  }

  TextStyle calculateStatusColor(String status) {
    if (status.contains("DELAY")) {
      return AaeTextStyles.departureDelayed;
    } else if (status.contains("CANCEL")) {
      return AaeTextStyles.departureCancelled;
    } else {
      return AaeTextStyles.departureOnTime;
    }
  }

  convertStringToDate(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    final df = new DateFormat('EEEEE, MMM d, yyyy');
    String date = df.format(todayDate);
    return date;
  }
}

class FlightStatusCardBody extends StatelessWidget {
  const FlightStatusCardBody({this.flightStatus});

  final FlightStatus flightStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 15),
      child: Row(
        children: [
          FlightStatusCardBodyColumn(
              '${_formatDate(flightStatus.originInfo.estimatedTime)}',
              '${flightStatus.originInfo.airportCode}',
              '${_formatDate(flightStatus.originInfo.scheduledTime)}',
              '${_isValueNull(flightStatus.originInfo.terminal)}',
              '${_isValueNull(flightStatus.originInfo.gate)}',
              null,
              true),
          FlightStatusCardBodyColumn(
              '${_formatDate(flightStatus.destinationInfo.estimatedTime)}',
              '${flightStatus.destinationInfo.airportCode}',
              '${_formatDate(flightStatus.destinationInfo.scheduledTime)}',
              '${_isValueNull(flightStatus.destinationInfo.terminal)}',
              '${_isValueNull(flightStatus.destinationInfo.gate)}',
              '${_isValueNull(flightStatus.baggageClaimArea)}',
              false),
        ],
      ),
    );
  }

  String _isValueNull(String value) {
    if (value == null || value == '') {
      value = '--';
    }
    return value;
  }

  String _formatDate(String time) {
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
  String terminal;
  String gate;
  String baggage;
  bool arrowIcon;

  FlightStatusCardBodyColumn(this.time, this.location, this.scheduledTime,
      this.terminal, this.gate, this.baggage, this.arrowIcon);

  @override
  Widget build(BuildContext context) {
    if (this.time == null || this.time == '') {
      time = this.scheduledTime;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 5),
          child: Row(children: [
            Container(
              padding: EdgeInsets.only(top: 12),
              child: Text(
                time,
                style: AaeTextStyles.flightStatusTimeText,
              ),
            ),
            _buildArrowIcon(arrowIcon),
          ]),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            location,
            style: AaeTextStyles.reservationSubHeading,
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            'Scheduled: ' + scheduledTime,
            style: AaeTextStyles.flightStatusText,
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            'Terminal: ' + terminal,
            style: AaeTextStyles.flightStatusText,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Text(
                  'Gate: ' + gate,
                  style: AaeTextStyles.flightStatusText,
                ),
              ),
              _isDestination(baggage)
            ],
          ),
        ),
      ],
    );
  }

  _isDestination(baggage) {
    if (baggage != null) {
      return Padding(
          padding: EdgeInsets.only(bottom: 0, left: 20),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 3, right: 5),
                child: Icon(
                  AaeIconsv4.bagInfo,
                  size: 11,
                  color: AaeColors.lightGrayText,
                ),
              ),
              Text(
                baggage,
                style: AaeTextStyles.flightStatusText,
              ),
            ],
          ));
    } else {
      return Container();
    }
  }

  Widget _buildArrowIcon(bool arrowIcon) {
    if (arrowIcon) {
      return Container(
        alignment: Alignment.topCenter,
        height: 18,
        padding: EdgeInsets.only(top: 0, left: 30, right: 30),
        child: Icon(
          AaeIconsv4.arrow_right,
          color: AaeColors.gray,
        ),
      );
    } else {
      return Container();
    }
  }
}
