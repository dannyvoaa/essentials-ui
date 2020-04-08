library news_feed_item;

import 'dart:convert';

import 'package:aae/model/author.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'news_feed_item.g.dart';

abstract class NewsFeedItem
    implements Built<NewsFeedItem, NewsFeedItemBuilder> {
  NewsFeedItem._();

  factory NewsFeedItem([updates(NewsFeedItemBuilder b)]) = _$NewsFeedItem;

  @BuiltValueField(wireName: 'author')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  Author get author;

  @BuiltValueField(wireName: 'category')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get category;

  @BuiltValueField(wireName: 'date')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  DateTime get date;

  @BuiltValueField(wireName: 'description')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get description;

  @BuiltValueField(wireName: 'id')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  int get id;

  @BuiltValueField(wireName: 'image')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  Uri get image;

  @BuiltValueField(wireName: 'title')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get title;

  String toJson() {
    return json
        .encode(serializers.serializeWith(NewsFeedItem.serializer, this));
  }

  static NewsFeedItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        NewsFeedItem.serializer, json.decode(jsonString));
  }

  static Serializer<NewsFeedItem> get serializer => _$newsFeedItemSerializer;
}
