import 'package:aae/assets/aae_icons.dart';
import 'package:aae/model/flight_status.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/flight_status/flight_status_view_model.dart';
import 'package:aae/travel/component/travel_list_tile/travel_full_button.dart';
import 'package:aae/travel/component/trips/tools_button.dart';
import 'package:aae/travel/component/trips/trips_collection.dart';
import 'package:flutter/material.dart';

class FlightStatusDetails<T> extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  FlightStatusDetails({this.viewModel, this.context, this.model});

  final BuildContext context;
  final FlightStatus model;
  final FlightStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return _buildFlightStatusDetails(context);
    } else {
      return _buildEmptyState(context);
    }
  }

  _buildFlightStatusDetails(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Flight status",
                        style: TextStyle(
                          fontSize: 15,
                          color: AaeColors.blue,
                          fontWeight: FontWeight.w700,
                          height: 2.6666666666666665,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )),
                Container(
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Image.asset(
                                  'assets/common/flight_symbol.png',
                                  width: AaeDimens.sizeDynamic_16px(),
                                )),
                            Expanded(
                              flex: 5,
                              child: Text(
                                '${viewModel.flightStatus.flightNumber} departs in 3 hr 18 min',
                                style: TextStyle(
                                  fontFamily: 'AmericanSans',
                                  fontSize: 12,
                                  color: const Color(0xff36495a),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${viewModel.flightStatus.status}',
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans Medium',
                                    fontSize: 12,
                                    color: const Color(0xff008712),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: ExpansionTile(
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: AaeColors.ultraLightGray),
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0, bottom: 5.0),
                                              child: Text(
                                                '${viewModel.flightStatus.originInfo.estimatedTime}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'AmericanSans Medium',
                                                  fontSize: 18,
                                                  color:
                                                      const Color(0xff36495a),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Text(
                                                '${viewModel.flightStatus.originInfo.airportCode}',
                                                style: TextStyle(
                                                  fontFamily: 'AmericanSans',
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff36495a),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            )
                                          ]))),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, bottom: 5.0),
                                                child: Icon(Icons.arrow_forward,
                                                    color: AaeColors
                                                        .ultraLightGray,
                                                    size: 20)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: AaeColors.lightGray,
                                                ),
                                              ),
                                            )
                                          ]))),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0, bottom: 5.0),
                                              child: Text(
                                                '${viewModel.flightStatus.destinationInfo.estimatedTime}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'AmericanSans Medium',
                                                  fontSize: 18,
                                                  color:
                                                      const Color(0xff36495a),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Text(
                                                    '${viewModel.flightStatus.destinationInfo.airportCode}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'AmericanSans',
                                                      fontSize: 14,
                                                      color: const Color(
                                                          0xff36495a),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0,
                                                          left: 5.0),
                                                  child: Icon(
                                                    AaeIconsv4.clock,
                                                    size: 12,
                                                    color: AaeColors
                                                        .ultraLightGray,
                                                  ),
                                                )
                                              ],
                                            )
                                          ]))),
                                ]),
                              ]),
                          children: <Widget>[
                            Text(
                              'Dallas/Fort Worth International Airport (DFW)',
                              style: TextStyle(
                                fontFamily: 'AmericanSans',
                                fontSize: 13,
                                color: const Color(0xff36495a),
                                height: 1.0769230769230769,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Row(children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Text(
                                  '12hr 5min',
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans',
                                    fontSize: 12,
                                    color: const Color(0xff9da6ab),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text(
                                  'Overnight',
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans',
                                    fontSize: 12,
                                    color: const Color(0xff9da6ab),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  'Main',
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans',
                                    fontSize: 12,
                                    color: const Color(0xff9da6ab),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Text(
                                  'Airbus 321',
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans',
                                    fontSize: 12,
                                    color: const Color(0xff9da6ab),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Text(
                                  'ICON',
                                  style: TextStyle(
                                    fontFamily: 'AmericanSans',
                                    fontSize: 12,
                                    color: const Color(0xff9da6ab),
                                  ),
                                ),
                              ),
                            ]),
                            Text(
                              'Madrid-Barajas Adolfo Suárez Airport(MAD)',
                              style: TextStyle(
                                fontFamily: 'AmericanSans',
                                fontSize: 13,
                                color: const Color(0xff36495a),
                                height: 1.0769230769230769,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: const Color(0xfff5f5f7),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 5.0),
                                        child: Text(
                                          'BOARDING',
                                          style: TextStyle(
                                            fontFamily: 'AmericanSans Medium',
                                            fontSize: 11,
                                            color: const Color(0xff9da6ab),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Text(
                                          '10:45 AM',
                                          style: TextStyle(
                                            fontFamily: 'AmericanSans',
                                            fontSize: 15,
                                            color: const Color(0xff36495a),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ]))),
                            Expanded(
                                flex: 2,
                                child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 5.0),
                                          child: Text(
                                            'GATE',
                                            style: TextStyle(
                                              fontFamily: 'AmericanSans Medium',
                                              fontSize: 11,
                                              color: const Color(0xff9da6ab),
                                            ),
                                            textAlign: TextAlign.left,
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Text(
                                          '${viewModel.flightStatus.originInfo.gate}',
                                          style: TextStyle(
                                            fontFamily: 'AmericanSans',
                                            fontSize: 15,
                                            color: const Color(0xff36495a),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ]))),
                            Expanded(
                                flex: 3,
                                child: Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 5.0),
                                      child: Text(
                                        'TERMINAL',
                                        style: TextStyle(
                                          fontFamily: 'AmericanSans Medium',
                                          fontSize: 11,
                                          color: const Color(0xff9da6ab),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Text(
                                        '${viewModel.flightStatus.originInfo.terminal}',
                                        style: TextStyle(
                                          fontFamily: 'AmericanSans',
                                          fontSize: 15,
                                          color: const Color(0xff36495a),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ))),
                          ]),
                        ),
                      ),
                    ]),
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
                    )),
                TripsCollection(viewModel: null, header: 'Tools'),
                RaisedButton(
                  onPressed: () => {Navigator.pop(context)},
                ),
              ],
            )),
        padding: const EdgeInsets.all(16.0));
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'Empty',
      ),
    );
  }
}
