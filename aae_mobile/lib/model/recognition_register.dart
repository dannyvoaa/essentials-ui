library recognition_register;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recognition_register.g.dart';

abstract class RecognitionRegister
    implements Built<RecognitionRegister, RecognitionRegisterBuilder> {
  RecognitionRegister._();

  factory RecognitionRegister([updates(RecognitionRegisterBuilder b)]) =
      _$RecognitionRegister;

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
        serializers.serializeWith(RecognitionRegister.serializer, this));
  }

  static RecognitionRegister fromJson(String jsonString) {
    return serializers.deserializeWith(
        RecognitionRegister.serializer, json.decode(jsonString));
  }

  static Serializer<RecognitionRegister> get serializer =>
      _$recognitionRegisterSerializer;
}
