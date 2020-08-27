library nfdocs;

import 'dart:convert';

import 'package:aae/model/event.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:aae/model/news_feed_item.dart';
import 'package:aae/model/serializers.dart';

import 'package:aae/model/news_feed_json_list.dart';

part 'nfdocs.g.dart';

abstract class Nfdocs implements Built<Nfdocs, NfdocsBuilder> {
  Nfdocs._();

  factory Nfdocs([updates(NfdocsBuilder b)]) = _$Nfdocs;

  @BuiltValueField(wireName: 'docs')
  BuiltList<NewsFeedJsonList> get nfjl;

  @BuiltValueField(wireName: 'bookmark')
  String get bookmark;

  String toJson() {
    return json.encode(serializers.serializeWith(Nfdocs.serializer, this));
  }

  static Nfdocs fromJson(String jsonString) {
    return serializers.deserializeWith(
        Nfdocs.serializer, json.decode(jsonString));
  }

  static Serializer<Nfdocs> get serializer => _$nfdocsSerializer;
}
