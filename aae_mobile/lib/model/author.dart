library author;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'author.g.dart';

abstract class Author implements Built<Author, AuthorBuilder> {
  Author._();

  factory Author([updates(AuthorBuilder b)]) = _$Author;

  @BuiltValueField(wireName: 'id')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  int get id;

  @BuiltValueField(wireName: 'image')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  Uri get image;

  @BuiltValueField(wireName: 'name')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get name;

  String toJson() {
    return json.encode(serializers.serializeWith(Author.serializer, this));
  }

  static Author fromJson(String jsonString) {
    return serializers.deserializeWith(
        Author.serializer, json.decode(jsonString));
  }

  static Serializer<Author> get serializer => _$authorSerializer;
}
