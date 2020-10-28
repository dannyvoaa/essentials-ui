library priority_list_passenger;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'priority_list_passenger.g.dart';

abstract class PriorityListPassenger implements Built<PriorityListPassenger, PriorityListPassengerBuilder> {
  PriorityListPassenger._();

  factory PriorityListPassenger([updates(PriorityListPassengerBuilder b)]) =
  _$PriorityListPassenger;

  @BuiltValueField(wireName: 'firstName')
  String get firstName;

  @BuiltValueField(wireName: 'lastName')
  String get lastName;

  @BuiltValueField(wireName: 'groupNumber')
  @nullable
  String get groupNumber;

  @BuiltValueField(wireName: 'priorityCode')
  @nullable
  String get priorityCode;

  @BuiltValueField(wireName: 'remarks')
  @nullable
  String get remarks;

  @BuiltValueField(wireName: 'seatNumber')
  @nullable
  String get seatNumber;

  @BuiltValueField(wireName: 'priorityNumber')
  @nullable
  int get priorityNumber;

  @BuiltValueField(wireName: 'cabin')
  @nullable
  String get cabin;

  String toJson() {
    return json
        .encode(serializers.serializeWith(PriorityListPassenger.serializer, this));
  }

  static PriorityListPassenger fromJson(String jsonString) {
    return serializers.deserializeWith(
        PriorityListPassenger.serializer, json.decode(jsonString));
  }

  static Serializer<PriorityListPassenger> get serializer =>
      _$priorityListPassengerSerializer;

}

