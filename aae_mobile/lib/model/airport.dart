library airport;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'airport.g.dart';

abstract class Airport implements Built<Airport, AirportBuilder> {
  Airport._();

  factory Airport([updates(AirportBuilder b)]) =
  _$Airport;

  @BuiltValueField(wireName: 'code')
  String get code;

  @BuiltValueField(wireName: 'displayName')
  String get displayName;

  String toJson() {
    return json
        .encode(serializers.serializeWith(Airport.serializer, this));
  }

  static Airport fromJson(String jsonString) {
    return serializers.deserializeWith(
        Airport.serializer, json.decode(jsonString));
  }

  static Serializer<Airport> get serializer =>
      _$airportSerializer;
}