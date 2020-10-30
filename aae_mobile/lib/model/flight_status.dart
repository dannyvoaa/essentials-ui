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

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'baggageClaimArea')
  String get baggageClaimArea;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'carrierCode')
  String get carrierCode;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'carrierName')
  String get carrierName;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'codeShare')
  bool get codeShare;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'dateChange')
  bool get dateChange;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'flightNumber')
  String get flightNumber;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'isWifiAvailable')
  bool get isWifiAvailable;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'operatingCarrierCode')
  String get operatingCarrierCode;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'destinationInfo')
  GateTimeFlightInfo get destinationInfo;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'originInfo')
  GateTimeFlightInfo get originInfo;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
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