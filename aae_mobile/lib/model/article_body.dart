import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'article_body.g.dart';

abstract class ArticleBody implements Built<ArticleBody, ArticleBodyBuilder> {
  ArticleBody._();

  factory ArticleBody([updates(ArticleBodyBuilder b)]) = _$ArticleBody;

  @BuiltValueField(wireName: "text")
  @nullable
  String get content;

  String toJson() {
    return json.encode(serializers.serializeWith(ArticleBody.serializer, this));
  }

  static ArticleBody fromJson(String jsonString) {
    return serializers.deserializeWith(
        ArticleBody.serializer, json.decode(jsonString));
  }

  static Serializer<ArticleBody> get serializer => _$articleBodySerializer;
}
