library docs;

import 'dart:convert';

import 'package:aae/model/event.dart';
import 'package:aae/model/stock_stats.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:aae/model/news_feed_item.dart';
import 'package:aae/model/serializers.dart';

import 'package:aae/model/news_feed_json_list.dart';

import 'package:aae/model/news_article.dart';

part 'news_articledocs.g.dart';

abstract class Newsarticledocs implements Built<Newsarticledocs, NewsarticledocsBuilder> {
  Newsarticledocs._();

  factory Newsarticledocs([updates(NewsarticledocsBuilder b)]) = _$Newsarticledocs;

  @BuiltValueField(wireName: 'docs')
  BuiltList<NewsArticle> get article;

  @BuiltValueField(wireName: 'bookmark')
  String get bookmark;

  String toJson() {
    return json.encode(serializers.serializeWith(Newsarticledocs.serializer, this));
  }

  static Newsarticledocs fromJson(String jsonString) {
    return serializers.deserializeWith(Newsarticledocs.serializer, json.decode(jsonString));
  }

  static Serializer<Newsarticledocs> get serializer => _$newsarticledocsSerializer;
}
