library trips;

import 'dart:convert';

import 'package:aae/model/pnr.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trips.g.dart';

abstract class Trips
    implements Built<Trips, TripsBuilder> {
  Trips._();

  factory Trips([updates(TripsBuilder b)]) =
  _$Trips;

  @BuiltValueField(wireName: 'pnrs')
  BuiltList<Pnr> get pnrs;
  set pnrs(BuiltList<Pnr> pnrs){
    this.pnrs = pnrs;
  }

  String toJson() {
    return json
        .encode(serializers.serializeWith(Trips.serializer, this));
  }

  static Trips fromJson(String jsonString) {
    return serializers.deserializeWith(
        Trips.serializer, json.decode(jsonString));
  }

  static Serializer<Trips> get serializer =>
      _$tripsSerializer;
}
