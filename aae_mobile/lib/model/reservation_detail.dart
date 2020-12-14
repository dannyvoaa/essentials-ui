library reservation_detail;

import 'dart:convert';

import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/model/reservation_detail_segment.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reservation_detail.g.dart';

abstract class ReservationDetail implements Built<ReservationDetail, ReservationDetailBuilder> {
  ReservationDetail._();

  factory ReservationDetail([updates(ReservationDetailBuilder b)]) =
  _$ReservationDetail;

  @BuiltValueField(wireName: 'description')
  String get description;

  @BuiltValueField(wireName: 'employeeId')
  String get employeeId;

  @BuiltValueField(wireName: 'firstDepartureDateTime')
  @nullable
  String get firstDepartureDateTime;

  @BuiltValueField(wireName: 'lastArrivalDateTime')
  @nullable
  String get lastArrivalDateTime;

  @BuiltValueField(wireName: 'passType')
  String get passType;

  @BuiltValueField(wireName: 'recordLocator')
  String get recordLocator;

  @BuiltValueField(wireName: 'passengers')
  BuiltList<ReservationDetailPassenger> get passengers;

  @BuiltValueField(wireName: 'segments')
  BuiltList<ReservationDetailSegment> get segments;

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

