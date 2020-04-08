library recognition_history;

import 'dart:convert';

import 'package:aae/model/recognition_register.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recognition_history.g.dart';

abstract class RecognitionHistory
    implements Built<RecognitionHistory, RecognitionHistoryBuilder> {
  RecognitionHistory._();

  factory RecognitionHistory([updates(RecognitionHistoryBuilder b)]) =
      _$RecognitionHistory;

  @BuiltValueField(wireName: 'current_balance')
  String get currentBalance;

  @BuiltValueField(wireName: 'recognition_register')
  BuiltList<RecognitionRegister> get recognitionRegister;

  String toJson() {
    return json
        .encode(serializers.serializeWith(RecognitionHistory.serializer, this));
  }

  static RecognitionHistory fromJson(String jsonString) {
    return serializers.deserializeWith(
        RecognitionHistory.serializer, json.decode(jsonString));
  }

  static Serializer<RecognitionHistory> get serializer =>
      _$recognitionHistorySerializer;
}
