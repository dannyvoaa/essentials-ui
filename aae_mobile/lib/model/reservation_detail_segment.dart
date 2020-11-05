library priority_list_cabin;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reservation_detail_segment.g.dart';

abstract class ReservationDetailSegment implements Built<ReservationDetailSegment, ReservationDetailSegmentBuilder> {
  ReservationDetailSegment._();

  factory ReservationDetailSegment([updates(ReservationDetailSegmentBuilder b)]) =
  _$ReservationDetailSegment;

  @BuiltValueField(wireName: 'firstName')
  String get firstName;

  @BuiltValueField(wireName: 'lastName')
  int get lastName;

  @BuiltValueField(wireName: 'nrsTravelerId')
  int get nrsTravelerId;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ReservationDetailSegment.serializer, this));
  }

  static ReservationDetailSegment fromJson(String jsonString) {
    return serializers.deserializeWith(
        ReservationDetailSegment.serializer, json.decode(jsonString));
  }

  static Serializer<ReservationDetailSegment> get serializer =>
      _$reservationDetailSegmentSerializer;

}

