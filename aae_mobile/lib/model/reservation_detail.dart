library priority_list;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reservation_detail.g.dart';

abstract class ReservationDetail implements Built<ReservationDetail, ReservationDetailBuilder> {
  ReservationDetail._();

  factory ReservationDetail([updates(ReservationDetailBuilder b)]) =
  _$ReservationDetail;

  @BuiltValueField(wireName: 'originAirportCode')
  String get originAirportCode;

  @BuiltValueField(wireName: 'destinationAirportCode')
  String get destinationAirportCode;

  @BuiltValueField(wireName: 'flightNumber')
  int get flightNumber;

  @BuiltValueField(wireName: 'departureTime')
  String get departureTime;

  @BuiltValueField(wireName: 'departureGate')
  String get departureGate;

  @BuiltValueField(wireName: 'cabins')
  BuiltList<ReservationDetailCabin> get cabins;

  @BuiltValueField(wireName: 'confirmedRevenueOversales')
  BuiltList<ReservationDetailPassenger> get confirmedRevenueOversales;

  @BuiltValueField(wireName: 'confirmedRevenueUpgrades')
  BuiltList<ReservationDetailPassenger> get confirmedRevenueUpgrades;

  @BuiltValueField(wireName: 'revenueStandbys')
  BuiltList<ReservationDetailPassenger> get revenueStandbys;

  @BuiltValueField(wireName: 'nonrevStandbys')
  BuiltList<ReservationDetailPassenger> get nonrevStandbys;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ReservationDetail.serializer, this));
  }

  static ReservationDetail fromJson(String jsonString) {
    return serializers.deserializeWith(
        ReservationDetail.serializer, json.decode(jsonString));
  }

  static Serializer<ReservationDetail> get serializer =>
      _$reservationDetailSerializer;

}

