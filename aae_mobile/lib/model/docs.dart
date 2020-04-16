library docs;

import 'dart:convert';

import 'package:aae/model/event.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'docs.g.dart';

abstract class Docs implements Built<Docs, DocsBuilder> {
  Docs._();

  factory Docs([updates(DocsBuilder b)]) = _$Docs;

  @BuiltValueField(wireName: 'docs')
  BuiltList<Event> get events;

  @BuiltValueField(wireName: 'bookmark')
  String get bookmark;

  String toJson() {
    return json.encode(serializers.serializeWith(Docs.serializer, this));
  }

  static Docs fromJson(String jsonString) {
    return serializers.deserializeWith(
        Docs.serializer, json.decode(jsonString));
  }

  static Serializer<Docs> get serializer => _$docsSerializer;
}
