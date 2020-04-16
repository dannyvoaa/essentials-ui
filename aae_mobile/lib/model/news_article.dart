import 'dart:convert';

import 'package:aae/model/article_body.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'news_article.g.dart';

abstract class NewsArticle implements Built<NewsArticle, NewsArticleBuilder> {
  factory NewsArticle([updates(NewsArticleBuilder b)]) = _$NewsArticle;

  NewsArticle._();

  /// [id] is the news article id.
  @BuiltValueField(wireName: "id")
  String get id;

  /// [authorName] is the data we retrieve from the server with no formatting in place.
  @BuiltValueField(wireName: "authorname")
  String get authorName;

  @BuiltValueField(wireName: "content")
  ArticleBody get contentString;

  @BuiltValueField(wireName: "contentID")
  String get contentID;

  static NewsArticle fromJson(String jsonString) => serializers.deserializeWith(
      NewsArticle.serializer, json.decode(jsonString));

  String toJson() =>
      json.encode(serializers.serializeWith(NewsArticle.serializer, this));

  static Serializer<NewsArticle> get serializer => _$newsArticleSerializer;

  //TODO(rpaglinawan)
}
