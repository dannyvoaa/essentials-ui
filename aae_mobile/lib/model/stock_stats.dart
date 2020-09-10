library stock_stats;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/built_value.dart';

part 'stock_stats.g.dart';

abstract class StockStats implements Built<StockStats, StockStatsBuilder> {
  StockStats._();

  factory StockStats([updates(StockStatsBuilder b)]) = _$StockStats;

  @BuiltValueField(wireName: 'AAL')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get price;

  @BuiltValueField(wireName: 'AALChange')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get aalChange;

  String toJson() {
    return json.encode(serializers.serializeWith(StockStats.serializer, this));
  }

  static StockStats fromJson(String jsonString) {
    return serializers.deserializeWith(
        StockStats.serializer, json.decode(jsonString));
  }

  static Serializer<StockStats> get serializer => _$stockStatsSerializer;
}
