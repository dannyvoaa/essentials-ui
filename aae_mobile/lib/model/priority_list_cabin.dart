library priority_list_cabin;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'priority_list_cabin.g.dart';

abstract class PriorityListCabin implements Built<PriorityListCabin, PriorityListCabinBuilder> {
  PriorityListCabin._();

  factory PriorityListCabin([updates(PriorityListCabinBuilder b)]) =
  _$PriorityListCabin;

  @BuiltValueField(wireName: 'cabin')
  String get cabinType;

  @BuiltValueField(wireName: 'assignedSeats')
  int get assignedSeats;

  @BuiltValueField(wireName: 'confirmedSeats')
  int get confirmedSeats;

  @BuiltValueField(wireName: 'unassignedSeats')
  int get unassignedSeats;

  String toJson() {
    return json
        .encode(serializers.serializeWith(PriorityListCabin.serializer, this));
  }

  static PriorityListCabin fromJson(String jsonString) {
    return serializers.deserializeWith(
        PriorityListCabin.serializer, json.decode(jsonString));
  }

  static Serializer<PriorityListCabin> get serializer =>
      _$priorityListCabinSerializer;

}

