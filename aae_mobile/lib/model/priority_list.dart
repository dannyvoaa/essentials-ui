library priority_list;

import 'dart:convert';

import 'package:aae/model/priority_list_cabin.dart';
import 'package:aae/model/priority_list_passenger.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'priority_list.g.dart';

abstract class PriorityList implements Built<PriorityList, PriorityListBuilder> {
  PriorityList._();

  factory PriorityList([updates(PriorityListBuilder b)]) =
  _$PriorityList;

  @nullable
  @BuiltValueField(wireName: 'originAirportCode')
  String get originAirportCode;

  @nullable
  @BuiltValueField(wireName: 'destinationAirportCode')
  String get destinationAirportCode;

  @nullable
  @BuiltValueField(wireName: 'flightNumber')
  int get flightNumber;

  @nullable
  @BuiltValueField(wireName: 'departureTime')
  String get departureTime;

  @nullable
  @BuiltValueField(wireName: 'departureGate')
  String get departureGate;

  @nullable
  @BuiltValueField(wireName: 'cabins')
  BuiltList<PriorityListCabin> get cabins;

  @nullable
  @BuiltValueField(wireName: 'confirmedRevenueOversales')
  BuiltList<PriorityListPassenger> get confirmedRevenueOversales;

  @nullable
  @BuiltValueField(wireName: 'confirmedRevenueUpgrades')
  BuiltList<PriorityListPassenger> get confirmedRevenueUpgrades;

  @nullable
  @BuiltValueField(wireName: 'revenueStandbys')
  BuiltList<PriorityListPassenger> get revenueStandbys;

  @nullable
  @BuiltValueField(wireName: 'nonrevStandbys')
  BuiltList<PriorityListPassenger> get nonrevStandbys;

  String toJson() {
    return json
        .encode(serializers.serializeWith(PriorityList.serializer, this));
  }

  static PriorityList fromJson(String jsonString) {
    return serializers.deserializeWith(
        PriorityList.serializer, json.decode(jsonString));
  }

  static Serializer<PriorityList> get serializer =>
      _$priorityListSerializer;

}

