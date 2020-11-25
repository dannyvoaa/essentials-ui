library dzerodocs;

import 'dart:convert';

import 'package:aae/model/performance_stats.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'dzerodocs.g.dart';

abstract class Dzerodocs implements Built<Dzerodocs, DzerodocsBuilder> {
  Dzerodocs._();

  factory Dzerodocs([updates(DzerodocsBuilder b)]) = _$Dzerodocs;

  @BuiltValueField(wireName: 'docs')
  BuiltList<PerformanceStats> get dzero;

  @BuiltValueField(wireName: 'bookmark')
  String get bookmark;

  String toJson() {
    return json.encode(serializers.serializeWith(Dzerodocs.serializer, this));
  }

  static Dzerodocs fromJson(String jsonString) {
    return serializers.deserializeWith(
        Dzerodocs.serializer, json.decode(jsonString));
  }

  static Serializer<Dzerodocs> get serializer => _$dzerodocsSerializer;
}
