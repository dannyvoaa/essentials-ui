library reservation_detail_segment;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:aae/model/reservation_detail_seat_assignment.dart';

part 'reservation_detail_segment.g.dart';

abstract class ReservationDetailSegment implements Built<ReservationDetailSegment, ReservationDetailSegmentBuilder> {
  ReservationDetailSegment._();

  factory ReservationDetailSegment([updates(ReservationDetailSegmentBuilder b)]) =
  _$ReservationDetailSegment;

  @BuiltValueField(wireName: 'aircraftName')
  String get aircraftName;

  @BuiltValueField(wireName: 'arrivalTimeActual')
  @nullable
  String get arrivalTimeActual;

  @BuiltValueField(wireName: 'arrivalTimeEstimated')
  String get arrivalTimeEstimated;

  @BuiltValueField(wireName: 'arrivalTimeScheduled')
  String get arrivalTimeScheduled;

  @BuiltValueField(wireName: 'cabin')
  String get cabin;

  @BuiltValueField(wireName: 'departureTimeActual')
  @nullable
  String get departureTimeActual;

  @BuiltValueField(wireName: 'departureTimeEstimated')
  String get departureTimeEstimated;

  @BuiltValueField(wireName: 'departureTimeScheduled')
  String get departureTimeScheduled;

  @BuiltValueField(wireName: 'destinationAirportCode')
  String get destinationAirportCode;

  @BuiltValueField(wireName: 'destinationCity')
  String get destinationCity;

  @BuiltValueField(wireName: 'destinationCountry')
  String get destinationCountry;

  @BuiltValueField(wireName: 'destinationGate')
  @nullable
  String get destinationGate;

  @BuiltValueField(wireName: 'destinationTerminal')
  @nullable
  String get destinationTerminal;

  @BuiltValueField(wireName: 'duration')
  int get duration;

  @BuiltValueField(wireName: 'flightNumber')
  int get flightNumber;

  @BuiltValueField(wireName: 'hasWifi')
  bool get hasWifi;

  @BuiltValueField(wireName: 'legNumber')
  int get legNumber;

  @BuiltValueField(wireName: 'originAirportCode')
  String get originAirportCode;

  @BuiltValueField(wireName: 'originCity')
  String get originCity;

  @BuiltValueField(wireName: 'originCountry')
  String get originCountry;

  @BuiltValueField(wireName: 'originGate')
  String get originGate;

  @BuiltValueField(wireName: 'originTerminal')
  String get originTerminal;

  @BuiltValueField(wireName: 'segmentNumber')
  int get segmentNumber;

  @BuiltValueField(wireName: 'status')
  String get status;

//  @BuiltValueField(wireName: 'seatAssignments')
//  BuiltList<ReservationDetailSeatAssignment get seatAssignments;

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

