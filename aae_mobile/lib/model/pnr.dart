library pnr;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pnr.g.dart';

abstract class Pnr
    implements Built<Pnr, PnrBuilder> {
  Pnr._();

  factory Pnr([updates(PnrBuilder b)]) =
  _$Pnr;
  
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
        .encode(serializers.serializeWith(Pnr.serializer, this));
  }

  static Pnr fromJson(String jsonString) {
    return serializers.deserializeWith(
        Pnr.serializer, json.decode(jsonString));
  }

  static Serializer<Pnr> get serializer =>
      _$pnrSerializer;
}
