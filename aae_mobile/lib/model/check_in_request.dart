library check_in_request;

import 'dart:convert';

import 'package:aae/model/check_in_passenger.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'check_in_request.g.dart';

abstract class CheckInRequest implements Built<CheckInRequest, CheckInRequestBuilder> {
  CheckInRequest._();

  factory CheckInRequest([updates(CheckInRequestBuilder b)]) =
  _$CheckInRequest;

  @BuiltValueField(wireName: 'pnr')
  String get pnr;

  @BuiltValueField(wireName: 'employeeId')
  String get employeeId;

  @BuiltValueField(wireName: 'passengers')
  BuiltList<ReservationDetailPassenger> get passengers;

  String toJson() {
    return json
        .encode(serializers.serializeWith(CheckInRequest.serializer, this));
  }

  static CheckInRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        CheckInRequest.serializer, json.decode(jsonString));
  }

  static Serializer<CheckInRequest> get serializer =>
      _$checkInRequestSerializer;

}