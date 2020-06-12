library pnr_info;

import 'dart:convert';

import 'package:aae/model/pnr_info.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pnr_info.g.dart';

abstract class PnrInfo
    implements Built<PnrInfo, PnrInfoBuilder> {
  PnrInfo._();

  factory PnrInfo([updates(PnrInfoBuilder b)]) =
  _$PnrInfo;
  
  @BuiltValueField(wireName: 'employeeNumber')
  String get employeeNumber;

  @BuiltValueField(wireName: 'pnr')
  String get pnr;

  @BuiltValueField(wireName: 'pnrDescription')
  String get pnrDescription;

  String toJson() {
    return json
        .encode(serializers.serializeWith(PnrInfo.serializer, this));
  }

  static PnrInfo fromJson(String jsonString) {
    return serializers.deserializeWith(
        PnrInfo.serializer, json.decode(jsonString));
  }

  static Serializer<PnrInfo> get serializer =>
      _$pnrInfoSerializer;
}
