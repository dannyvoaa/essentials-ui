library reservation_detail_seat_assignment;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reservation_detail_seat_assignment.g.dart';

abstract class ReservationDetailSeatAssignment implements Built<ReservationDetailSeatAssignment, ReservationDetailSeatAssignmentBuilder> {
  ReservationDetailSeatAssignment._();

  factory ReservationDetailSeatAssignment([updates(ReservationDetailSeatAssignmentBuilder b)]) =
  _$ReservationDetailSeatAssignment;

  @BuiltValueField(wireName: 'passengerId')
  String get passengerId;

  @BuiltValueField(wireName: 'seatAssignment')
  @nullable
  String get seatAssignment;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ReservationDetailSeatAssignment.serializer, this));
  }

  static ReservationDetailSeatAssignment fromJson(String jsonString) {
    return serializers.deserializeWith(
        ReservationDetailSeatAssignment.serializer, json.decode(jsonString));
  }

  static Serializer<ReservationDetailSeatAssignment> get serializer =>
      _$reservationDetailSeatAssignmentSerializer;

}

