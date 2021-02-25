//_library check_in_passenger;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'check_in_passenger.g.dart';

abstract class CheckInPassenger implements Built<CheckInPassenger, CheckInPassengerBuilder> {
  CheckInPassenger._();

  factory CheckInPassenger([updates(CheckInPassengerBuilder b)]) =
  _$CheckInPassenger;

  @BuiltValueField(wireName: 'firstName')
  @nullable
  String get firstName;

  @BuiltValueField(wireName: 'lastName')
  @nullable
  String get lastName;

  @BuiltValueField(wireName: 'nrsTravelerId')
  @nullable
  int get nrsTravelerId;

  @BuiltValueField(wireName: 'passengerId')
  @nullable
  String get passengerId;

  String toJson() {
    return json
        .encode(serializers.serializeWith(CheckInPassenger.serializer, this));
  }

  static CheckInPassenger fromJson(String jsonString) {
    return serializers.deserializeWith(
        CheckInPassenger.serializer, json.decode(jsonString));
  }

  static Serializer<CheckInPassenger> get serializer =>
      _$checkInPassengerSerializer;

}