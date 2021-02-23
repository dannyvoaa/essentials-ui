library boardingpasswrapper;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'boarding_pass.dart';

part 'boarding_pass_wrapper.g.dart';

abstract class BoardingPassWrapper
    implements Built<BoardingPassWrapper, BoardingPassWrapperBuilder> {
  BoardingPassWrapper._();

  factory BoardingPassWrapper([updates(BoardingPassWrapperBuilder b)]) =
  _$BoardingPassWrapper;

  @BuiltValueField(wireName: 'boardingPasses')
  BuiltList<BoardingPass> get boardingPasses;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BoardingPassWrapper.serializer, this));
  }

  static BoardingPassWrapper fromJson(String jsonString) {
    return serializers.deserializeWith(
        BoardingPassWrapper.serializer, json.decode(jsonString));
  }

  static Serializer<BoardingPassWrapper> get serializer =>
      _$boardingPassWrapperSerializer;
}
