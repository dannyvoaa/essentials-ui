library news_feed;

import 'dart:convert';

import 'package:aae/model/news_feed_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'news_feed.g.dart';

abstract class NewsFeed implements Built<NewsFeed, NewsFeedBuilder> {
  NewsFeed._();

  factory NewsFeed([updates(NewsFeedBuilder b)]) = _$NewsFeed;

  @BuiltValueField(wireName: 'list')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  BuiltList<NewsFeedItem> get newsFeedItemList;

  String toJson() {
    return json.encode(serializers.serializeWith(NewsFeed.serializer, this));
  }

  static NewsFeed fromJson(String jsonString) {
    return serializers.deserializeWith(
        NewsFeed.serializer, json.decode(jsonString));
  }

  static Serializer<NewsFeed> get serializer => _$newsFeedSerializer;
}
