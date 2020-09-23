library flightstatus;

import 'dart:convert';

import 'package:aae/model/gate_time_flight_info.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_status.g.dart';

abstract class FlightStatus
    implements Built<FlightStatus, FlightStatusBuilder> {
  FlightStatus._();

  factory FlightStatus([updates(FlightStatusBuilder b)]) =
  _$FlightStatus;
  
  @BuiltValueField(wireName: 'baggageClaimArea')
  String get baggageClaimArea;

  @BuiltValueField(wireName: 'carrierCode')
  String get carrierCode;

  @BuiltValueField(wireName: 'carrierName')
  String get carrierName;

  @BuiltValueField(wireName: 'codeShare')
  String get codeShare;

  @BuiltValueField(wireName: 'dateChange')
  String get dateChange;

  @BuiltValueField(wireName: 'flightNumber')
  String get flightNumber;

  @BuiltValueField(wireName: 'isWifiAvailable')
  String get isWifiAvailable;

  @BuiltValueField(wireName: 'operatingCarrierCode')
  String get operatingCarrierCode;

  @BuiltValueField(wireName: 'destinationInfo')
  GateTimeFlightInfo get destinationInfo;

  @BuiltValueField(wireName: 'originInfo')
  GateTimeFlightInfo get originInfo;

  @BuiltValueField(wireName: 'status')
  String get status;

  String toJson() {
    return json
        .encode(serializers.serializeWith(FlightStatus.serializer, this));
  }

  static FlightStatus fromJson(String jsonString) {
    return serializers.deserializeWith(
        FlightStatus.serializer, json.decode(jsonString));
  }

  static Serializer<FlightStatus> get serializer =>
      _$flightStatusSerializer;
}
