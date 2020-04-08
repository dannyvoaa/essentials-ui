library profile;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:aae/model/topics.dart';
import 'package:aae/model/workgroup.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'profile.g.dart';

abstract class Profile implements Built<Profile, ProfileBuilder> {
  Profile._();

  factory Profile([updates(ProfileBuilder b)]) = _$Profile;

  @BuiltValueField(wireName: 'aaid')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get aaId;

  @BuiltValueField(wireName: 'jiveid')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get jiveId;

  @BuiltValueField(wireName: 'profileimage')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get profileImage;

  @BuiltValueField(wireName: 'topics')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  BuiltList<Topics> get topics;

  @BuiltValueField(wireName: 'workgroup')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  BuiltList<Workgroup> get workgroup;

  String toJson() {
    return json.encode(serializers.serializeWith(Profile.serializer, this));
  }

  static Profile fromJson(String jsonString) {
    return serializers.deserializeWith(
        Profile.serializer, json.decode(jsonString));
  }

  static Serializer<Profile> get serializer => _$profileSerializer;
}
