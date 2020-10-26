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

part 'stockdocs.g.dart';

abstract class Stockdocs implements Built<Stockdocs, StockdocsBuilder> {
  Stockdocs._();

  factory Stockdocs([updates(StockdocsBuilder b)]) = _$Stockdocs;

  @BuiltValueField(wireName: 'docs')
  BuiltList<StockStats> get stocks;

  @BuiltValueField(wireName: 'bookmark')
  String get bookmark;

  String toJson() {
    return json.encode(serializers.serializeWith(Stockdocs.serializer, this));
  }

  static Stockdocs fromJson(String jsonString) {
    return serializers.deserializeWith(Stockdocs.serializer, json.decode(jsonString));
  }

  static Serializer<Stockdocs> get serializer => _$stockdocsSerializer;
}
