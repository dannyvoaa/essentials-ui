library topics;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'topics.g.dart';

abstract class Topics implements Built<Topics, TopicsBuilder> {
  Topics._();

  factory Topics([updates(TopicsBuilder b)]) = _$Topics;

  @BuiltValueField(wireName: 'topics')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get topics;

  String toJson() {
    return json.encode(serializers.serializeWith(Topics.serializer, this));
  }

  static Topics fromJson(String jsonString) {
    return serializers.deserializeWith(
        Topics.serializer, json.decode(jsonString));
  }

  static Serializer<Topics> get serializer => _$topicsSerializer;
}
