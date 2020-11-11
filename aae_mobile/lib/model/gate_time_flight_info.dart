library gatetimeflightinfo;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gate_time_flight_info.g.dart';

abstract class GateTimeFlightInfo
    implements Built<GateTimeFlightInfo, GateTimeFlightInfoBuilder> {
  GateTimeFlightInfo._();

  factory GateTimeFlightInfo([updates(GateTimeFlightInfoBuilder b)]) =
  _$GateTimeFlightInfo;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'actualTime')
  String get actualTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'airportCode')
  String get airportCode;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'estimatedTime')
  String get estimatedTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'gate')
  String get gate;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'scheduledTime')
  String get scheduledTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'status')
  String get status;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'terminal')
  String get terminal;

  String toJson() {
    return json
        .encode(serializers.serializeWith(GateTimeFlightInfo.serializer, this));
  }

  static GateTimeFlightInfo fromJson(String jsonString) {
    return serializers.deserializeWith(
        GateTimeFlightInfo.serializer, json.decode(jsonString));
  }

  static Serializer<GateTimeFlightInfo> get serializer =>
      _$gateTimeFlightInfoSerializer;
}