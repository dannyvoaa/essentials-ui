library settings_item;

import 'dart:convert';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/topics.dart';
import 'package:aae/model/workgroup.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'preference_item.g.dart';

abstract class PreferenceItem
    implements Built<PreferenceItem, PreferenceItemBuilder> {
  PreferenceItem._();

  factory PreferenceItem([updates(PreferenceItemBuilder b)]) = _$PreferenceItem;

  @BuiltValueField(wireName: 'topic')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  BuiltList<Topics> get topicPReference;

  @BuiltValueField(wireName: 'workgroup')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  BuiltList<Workgroup> get workgroupPreference;

  String toJson() {
    return json
        .encode(serializers.serializeWith(PreferenceItem.serializer, this));
  }

  static PreferenceItem fromJson(String jsonString) {
    return serializers.deserializeWith(
        PreferenceItem.serializer, json.decode(jsonString));
  }

  static Serializer<PreferenceItem> get serializer =>
      _$preferenceItemSerializer;
}
