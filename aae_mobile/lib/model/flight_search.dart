library flightsearchresults;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flight_search.g.dart';

abstract class FlightSearch
    implements Built<FlightSearch, FlightSearchBuilder> {
  FlightSearch._();

  factory FlightSearch([updates(FlightSearchBuilder b)]) = _$FlightSearch;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'routes')
  BuiltList<FlightRoute> get flightRoutes;

  String toJson() {
    return json
        .encode(serializers.serializeWith(FlightSearch.serializer, this));
  }

  static FlightSearch fromJson(String jsonString) {
    return serializers.deserializeWith(
        FlightSearch.serializer, json.decode(jsonString));
  }

  static Serializer<FlightSearch> get serializer => _$flightSearchSerializer;
}

abstract class FlightRoute implements Built<FlightRoute, FlightRouteBuilder> {
  FlightRoute._();

  factory FlightRoute([updates(FlightRouteBuilder b)]) = _$FlightRoute;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'segments')
  BuiltList<FlightSegment> get flightSegments;

  String toJson() {
    return json.encode(serializers.serializeWith(FlightRoute.serializer, this));
  }

  static FlightRoute fromJson(String jsonString) {
    return serializers.deserializeWith(
        FlightRoute.serializer, json.decode(jsonString));
  }

  static Serializer<FlightRoute> get serializer => _$flightRouteSerializer;
}

abstract class FlightSegment
    implements Built<FlightSegment, FlightSegmentBuilder> {
  FlightSegment._();

  factory FlightSegment([updates(FlightSegmentBuilder b)]) = _$FlightSegment;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'legs')
  BuiltList<FlightLeg> get flightLegs;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'flightNumber')
  String get flightNumber;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'displayCarrier')
  String get displayCarrier;

  String toJson() {
    return json
        .encode(serializers.serializeWith(FlightSegment.serializer, this));
  }

  static FlightSegment fromJson(String jsonString) {
    return serializers.deserializeWith(
        FlightSegment.serializer, json.decode(jsonString));
  }

  static Serializer<FlightSegment> get serializer => _$flightSegmentSerializer;
}

abstract class FlightLeg implements Built<FlightLeg, FlightLegBuilder> {
  FlightLeg._();

  factory FlightLeg([updates(FlightLegBuilder b)]) = _$FlightLeg;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'origin')
  FlightAirport get origin;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'destination')
  FlightAirport get destination;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'scheduledDepartureDateTime')
  String get scheduledDepartureDateTime;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'scheduledArrivalDateTime')
  String get scheduledArrivalDateTime;

  String toJson() {
    return json.encode(serializers.serializeWith(FlightLeg.serializer, this));
  }

  static FlightLeg fromJson(String jsonString) {
    return serializers.deserializeWith(
        FlightLeg.serializer, json.decode(jsonString));
  }

  static Serializer<FlightLeg> get serializer => _$flightLegSerializer;
}

abstract class FlightAirport
    implements Built<FlightAirport, FlightAirportBuilder> {
  FlightAirport._();

  factory FlightAirport([updates(FlightAirportBuilder b)]) = _$FlightAirport;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'code')
  String get code;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'city')
  String get city;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'latitude')
  String get latitude;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'longitude')
  String get longitude;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'countryName')
  String get countryName;

  @BuiltValueSerializer(serializeNulls: true)
  @nullable
  @BuiltValueField(wireName: 'countryCode')
  String get countryCode;

  String toJson() {
    return json
        .encode(serializers.serializeWith(FlightAirport.serializer, this));
  }

  static FlightAirport fromJson(String jsonString) {
    return serializers.deserializeWith(
        FlightAirport.serializer, json.decode(jsonString));
  }

  static Serializer<FlightAirport> get serializer => _$flightAirportSerializer;
}