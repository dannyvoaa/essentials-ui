library news_feed_item;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'news_feed_item.g.dart';

abstract class NewsFeedItem implements Built<NewsFeedItem, NewsFeedItemBuilder> {
  NewsFeedItem._();

  factory NewsFeedItem([updates(NewsFeedItemBuilder b)]) = _$NewsFeedItem;

  @BuiltValueField(wireName: 'authorname')
  String get author;

  @BuiltValueField(wireName: 'bodytext')
  String get body;

  @BuiltValueField(wireName: 'contentID')
  String get contentID;

  @BuiltValueField(wireName: 'id')
  String get id;

  @BuiltValueField(wireName: 'image')
  Uri get image;

  @BuiltValueField(wireName: 'subject')
  String get subject;

  String toJson() {
    return json.encode(serializers.serializeWith(NewsFeedItem.serializer, this));
  }

  static NewsFeedItem fromJson(String jsonString) {
    return serializers.deserializeWith(NewsFeedItem.serializer, json.decode(jsonString));
  }

  static Serializer<NewsFeedItem> get serializer => _$newsFeedItemSerializer;
}
