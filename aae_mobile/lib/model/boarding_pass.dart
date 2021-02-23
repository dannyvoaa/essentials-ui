library boardingpass;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'boarding_pass.g.dart';

abstract class BoardingPass
implements Built<BoardingPass, BoardingPassBuilder> {
  BoardingPass._();

  factory BoardingPass([updates(BoardingPassBuilder b)]) = _$BoardingPass;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'pnrCode')
  String get pnrCode;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'arrivalTime')
  String get arrivalTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'estimatedArrivalTime')
  String get estimatedArrivalTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'arrivalTimezone')
  String get arrivalTimezone;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'boardingTime')
  String get boardingTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'estimatedBoardingTime')
  String get estimatedBoardingTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'boardingTimezone')
  String get boardingTimezone;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'departureTime')
  String get departureTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'estimatedDepartureTime')
  String get estimatedDepartureTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'departureTimezone')
  String get departureTimezone;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'flightNumber')
  String get flightNumber;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'fromCityCode')
  String get fromCityCode;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'toCityCode')
  String get toCityCode;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'gateInfo')
  String get gateInfo;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'terminal')
  String get terminal;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'travelerId')
  int get travelerId;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'firstName')
  String get firstName;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'lastName')
  String get lastName;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'seatNumber')
  String get seatNumber;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'checkinSequenceNumber')
  int get checkinSequenceNumber;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'groupInfo')
  String get groupInfo;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'isTsaPrecheck')
  bool get isTsaPrecheck;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BoardingPass.serializer, this));
  }

  static BoardingPass fromJson(String jsonString) {
    return serializers.deserializeWith(
        BoardingPass.serializer, json.decode(jsonString));
  }

  static Serializer<BoardingPass> get serializer =>
      _$boardingPassSerializer;
}