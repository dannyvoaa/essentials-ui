library performance_stats;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'performance_stats.g.dart';

abstract class PerformanceStats implements Built<PerformanceStats, PerformanceStatsBuilder> {
  PerformanceStats._();

  factory PerformanceStats([updates(PerformanceStatsBuilder b)]) = _$PerformanceStats;

  @nullable
  @BuiltValueField(wireName: 'A14')
  String get a14;

  @BuiltValueField(wireName: 'A14Change')
  String get a14Change;

  @BuiltValueField(wireName: 'CF')
  String get cf;

  @BuiltValueField(wireName: 'CFChange')
  String get cfChange;

  @BuiltValueField(wireName: 'D0')
  String get d0;

  @BuiltValueField(wireName: 'D0Change')
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
