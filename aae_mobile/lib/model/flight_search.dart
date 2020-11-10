library flightsearchresults;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_search.g.dart';

abstract class FlightSearch
    implements Built<FlightSearch, FlightSearchBuilder> {
  FlightSearch._();

  factory FlightSearch([updates(FlightSearchBuilder b)]) =
  _$FlightSearch;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'carrierCode')
  String get carrierCode;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'flightNumber')
  String get flightNumber;

  String toJson() {
    return json
        .encode(serializers.serializeWith(FlightSearch.serializer, this));
  }

  static FlightSearch fromJson(String jsonString) {
    return serializers.deserializeWith(
        FlightSearch.serializer, json.decode(jsonString));
  }

  static Serializer<FlightSearch> get serializer =>
      _$flightSearchSerializer;
}

//
//abstract class FlightLeg
//    implements Built<FlightSearch, FlightLegBuilder> {
//  FlightLeg._();
//
//  factory FlightLeg([updates(FlightLegBuilder b)]) =
//  _$FlightLeg;
//
//  @BuiltValueSerializer(serializeNulls: true)
//  @nullable
//  @BuiltValueField(wireName: 'carrierCode')
//  String get carrierCode;
//
//  @BuiltValueSerializer(serializeNulls: true)
//  @nullable
//  @BuiltValueField(wireName: 'flightNumber')
//  String get flightNumber;
//
//  String toJson() {
//    return json
//        .encode(serializers.serializeWith(FlightLeg.serializer, this));
//  }
//
//  static FlightLeg fromJson(String jsonString) {
//    return serializers.deserializeWith(
//        FlightLeg.serializer, json.decode(jsonString));
//  }
//
//  static Serializer<FlightLeg> get serializer =>
//      _$flightLegSerializer;
//}