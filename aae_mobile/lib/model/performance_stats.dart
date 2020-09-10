library performance_stats;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'performance_stats.g.dart';

abstract class PerformanceStats implements Built<PerformanceStats, PerformanceStatsBuilder> {
  PerformanceStats._();

  factory PerformanceStats([updates(PerformanceStatsBuilder b)]) = _$PerformanceStats;

  @BuiltValueField(wireName: 'A14')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get a14;

  @BuiltValueField(wireName: 'A14Change')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get a14Change;

  @BuiltValueField(wireName: 'CF')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get cf;

  @BuiltValueField(wireName: 'CFChange')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get cfChange;

  @BuiltValueField(wireName: 'D0')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get d0;

  @BuiltValueField(wireName: 'D0Change')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get d0Change;

  String toJson() {
    return json.encode(serializers.serializeWith(PerformanceStats.serializer, this));
  }

  static PerformanceStats fromJson(String jsonString) {
    return serializers.deserializeWith(
        PerformanceStats.serializer, json.decode(jsonString));
  }

  static Serializer<PerformanceStats> get serializer => _$performanceStatsSerializer;
}
