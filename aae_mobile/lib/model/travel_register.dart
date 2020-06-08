library travel_register;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'travel_register.g.dart';

abstract class TravelRegister
    implements Built<TravelRegister, TravelRegisterBuilder> {
  TravelRegister._();

  factory TravelRegister([updates(TravelRegisterBuilder b)]) =
      _$TravelRegister;

  @BuiltValueField(wireName: 'id')
  String get id;

  @BuiltValueField(wireName: 'date')
  String get date;

  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'message')
  String get message;

  @BuiltValueField(wireName: 'amount')
  String get amount;

  @BuiltValueField(wireName: 'avatar_url')
  String get avatarUrl;

  String toJson() {
    return json.encode(
        serializers.serializeWith(TravelRegister.serializer, this));
  }

  static TravelRegister fromJson(String jsonString) {
    return serializers.deserializeWith(
        TravelRegister.serializer, json.decode(jsonString));
  }

  static Serializer<TravelRegister> get serializer =>
      _$travelRegisterSerializer;
}
