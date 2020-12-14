library airports;

import 'dart:convert';

import 'package:aae/model/pnr.dart';
import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'airport.dart';

part 'airports_wrapper.g.dart';

abstract class AirportsWrapper
    implements Built<AirportsWrapper, AirportsWrapperBuilder> {
  AirportsWrapper._();

  factory AirportsWrapper([updates(AirportsWrapperBuilder b)]) =
  _$AirportsWrapper;

  @BuiltValueField(wireName: 'airports')
  BuiltList<Airport> get airports;
  set airports(BuiltList<Airport> airports){
    this.airports = airports;
  }

  String toJson() {
    return json
        .encode(serializers.serializeWith(AirportsWrapper.serializer, this));
  }

  static AirportsWrapper fromJson(String jsonString) {
    return serializers.deserializeWith(
        AirportsWrapper.serializer, json.decode(jsonString));
  }

  static Serializer<AirportsWrapper> get serializer =>
      _$airportsWrapperSerializer;
}
