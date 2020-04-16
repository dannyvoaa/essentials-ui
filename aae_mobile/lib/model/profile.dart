library profile;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'profile.g.dart';

abstract class Profile implements Built<Profile, ProfileBuilder> {
  Profile._();

  factory Profile([updates(ProfileBuilder b)]) = _$Profile;

  @nullable
  @BuiltValueField(wireName: 'location')
  String get location;

  @BuiltValueField(wireName: 'username')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get username;

  @BuiltValueField(wireName: 'email')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get email;

  @BuiltValueField(wireName: 'displayName')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  String get displayName;

  @BuiltValueField(wireName: 'topics')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  BuiltList<String> get topics;

  @BuiltValueField(wireName: 'workgroup')
  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  BuiltList<String> get workgroup;

  String toJson() {
    return json.encode(serializers.serializeWith(Profile.serializer, this));
  }

  static Profile fromJson(String jsonString) {
    return serializers.deserializeWith(
        Profile.serializer, json.decode(jsonString));
  }

  static Serializer<Profile> get serializer => _$profileSerializer;
}
