library hubLocation;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hub_location.g.dart';

abstract class HubLocation implements Built<HubLocation, HubLocationBuilder> {
  HubLocation._();

  factory HubLocation([updates(HubLocationBuilder b)]) = _$HubLocation;

  @BuiltValueField(wireName: 'hublocation')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get hubLocations;

  String toJson() {
    return json.encode(serializers.serializeWith(HubLocation.serializer, this));
  }

  static HubLocation fromJson(String jsonString) {
    return serializers.deserializeWith(
        HubLocation.serializer, json.decode(jsonString));
  }

  static Serializer<HubLocation> get serializer => _$hubLocationSerializer;
}
