library workgroup;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workgroup.g.dart';

abstract class Workgroup implements Built<Workgroup, WorkgroupBuilder> {
  Workgroup._();

  factory Workgroup([updates(WorkgroupBuilder b)]) = _$Workgroup;

  @BuiltValueField(wireName: 'workgroup')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get workgroups;

  String toJson() {
    return json.encode(serializers.serializeWith(Workgroup.serializer, this));
  }

  static Workgroup fromJson(String jsonString) {
    return serializers.deserializeWith(
        Workgroup.serializer, json.decode(jsonString));
  }

  static Serializer<Workgroup> get serializer => _$workgroupSerializer;
}
