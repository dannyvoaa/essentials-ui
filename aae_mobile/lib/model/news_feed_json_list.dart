library news_feed;

import 'dart:convert';

import 'package:aae/model/news_feed_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'news_feed_json_list.g.dart';

abstract class NewsFeedJsonList implements Built<NewsFeedJsonList, NewsFeedJsonListBuilder> {
  NewsFeedJsonList._();

  factory NewsFeedJsonList([updates(NewsFeedJsonListBuilder b)]) = _$NewsFeedJsonList;

  @BuiltValueField(wireName: 'list')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  BuiltList<NewsFeedItem> get newsFeedJsonList;

  String toJson() {
    return json.encode(serializers.serializeWith(NewsFeedJsonList.serializer, this));
  }

  static NewsFeedJsonList fromJson(String jsonString) {
    return serializers.deserializeWith(NewsFeedJsonList.serializer, json.decode(jsonString));
  }

  static Serializer<NewsFeedJsonList> get serializer => _$newsFeedJsonListSerializer;
}
