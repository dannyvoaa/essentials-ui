library reservation_detail_passenger_info;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reservation_detail_passenger_info.g.dart';

abstract class ReservationDetailPassengerInfo implements Built<ReservationDetailPassengerInfo, ReservationDetailPassengerInfoBuilder> {
  ReservationDetailPassengerInfo._();

  factory ReservationDetailPassengerInfo([updates(ReservationDetailPassengerInfoBuilder b)]) =
  _$ReservationDetailPassengerInfo;

  @BuiltValueField(wireName: 'checkedIn')
  @nullable
  bool get checkedIn;

  @BuiltValueField(wireName: 'nrsTravelerId')
  @nullable
  int get nrsTravelerId;

  @BuiltValueField(wireName: 'passengerId')
  String get passengerId;

  @BuiltValueField(wireName: 'seatAssignment')
  @nullable
  String get seatAssignment;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ReservationDetailPassengerInfo.serializer, this));
  }

  static ReservationDetailPassengerInfo fromJson(String jsonString) {
    return serializers.deserializeWith(
        ReservationDetailPassengerInfo.serializer, json.decode(jsonString));
  }

  static Serializer<ReservationDetailPassengerInfo> get serializer =>
      _$reservationDetailPassengerInfoSerializer;

}