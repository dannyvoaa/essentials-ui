library check_in_request;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'check_in_basic_request.g.dart';

abstract class CheckInBasicRequest implements Built<CheckInBasicRequest, CheckInBasicRequestBuilder> {
  CheckInBasicRequest._();

  factory CheckInBasicRequest([updates(CheckInBasicRequestBuilder b)]) =
  _$CheckInBasicRequest;

  @BuiltValueField(wireName: 'travelerIds')
  BuiltList<int> get travelerIds;

  String toJson() {
    return json
        .encode(serializers.serializeWith(CheckInBasicRequest.serializer, this));
  }

  static CheckInBasicRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        CheckInBasicRequest.serializer, json.decode(jsonString));
  }

  static Serializer<CheckInBasicRequest> get serializer =>
      _$checkInBasicRequestSerializer;

}