library priority_list_cabin;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reservation_detail_passenger.g.dart';

abstract class ReservationDetailPassenger implements Built<ReservationDetailPassenger, ReservationDetailPassengerBuilder> {
  ReservationDetailPassenger._();

  factory ReservationDetailPassenger([updates(ReservationDetailPassengerBuilder b)]) =
  _$ReservationDetailPassenger;

  @BuiltValueField(wireName: 'firstName')
  String get firstName;

  @BuiltValueField(wireName: 'lastName')
  int get lastName;

  @BuiltValueField(wireName: 'nrsTravelerId')
  int get nrsTravelerId;

  @BuiltValueField(wireName: 'passengerId')
  int get passengerId;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ReservationDetailPassenger.serializer, this));
  }

  static ReservationDetailPassenger fromJson(String jsonString) {
    return serializers.deserializeWith(
        ReservationDetailPassenger.serializer, json.decode(jsonString));
  }

  static Serializer<ReservationDetailPassenger> get serializer =>
      _$reservationDetailPassengerSerializer;

}

