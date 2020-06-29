library pnrs;

import 'dart:convert';

import 'package:aae/model/pnrs.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pnrs.g.dart';

abstract class Pnrs
    implements Built<Pnrs, PnrsBuilder> {
  Pnrs._();

  factory Pnrs([updates(PnrsBuilder b)]) =
  _$Pnrs;
  
  @BuiltValueField(wireName: 'employeeId')
  String get employeeId;

  @BuiltValueField(wireName: 'recordLocator')
  String get recordLocator;

  @BuiltValueField(wireName: 'description')
  String get description;

  @BuiltValueField(wireName: 'firstDepartureDateTime')
  String get firstDepartureDateTime;

  @BuiltValueField(wireName: 'lastArrivalDateTime')
  String get lastArrivalDateTime;


  @BuiltValueField(wireName: 'passType')
  String get passType;

  @BuiltValueField(wireName: 'status')
  String get status;


  String toJson() {
    return json
        .encode(serializers.serializeWith(Pnrs.serializer, this));
  }

  static Pnrs fromJson(String jsonString) {
    return serializers.deserializeWith(
        Pnrs.serializer, json.decode(jsonString));
  }

  static Serializer<Pnrs> get serializer =>
      _$pnrsSerializer;
}
