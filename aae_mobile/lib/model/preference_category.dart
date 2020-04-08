library preference_category;

import 'dart:convert';
import 'package:aae/model/preference_item.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/topics.dart';
import 'package:aae/model/workgroup.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'preference_category.g.dart';

abstract class PreferenceCategory
    implements Built<PreferenceCategory, PreferenceCategoryBuilder> {
  PreferenceCategory._();

  factory PreferenceCategory([updates(PreferenceCategoryBuilder b)]) =
      _$PreferenceCategory;

  @BuiltValueField(wireName: 'preference_category')
  BuiltList<PreferenceItem> get category;

  String toJson() {
    return json
        .encode(serializers.serializeWith(PreferenceCategory.serializer, this));
  }

  static PreferenceCategory fromJson(String jsonString) {
    return serializers.deserializeWith(
        PreferenceCategory.serializer, json.decode(jsonString));
  }

  static Serializer<PreferenceCategory> get serializer =>
      _$preferenceCategorySerializer;
}
