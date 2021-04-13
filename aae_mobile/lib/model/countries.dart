library countries;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'countries.g.dart';

abstract class Country implements Built<Country, CountryBuilder> {
  Country._();

  factory Country([updates(CountryBuilder b)]) = _$Country;

  @BuiltValueField(wireName: 'countryCode')
  String get countryCode;

  @BuiltValueField(wireName: 'countryName')
  String get countryName;

  String toJson() {
    return json.encode(serializers.serializeWith(Country.serializer, this));
  }

  static Country fromJson(String jsonString) {
    return serializers.deserializeWith(
        Country.serializer, json.decode(jsonString));
  }

  static Serializer<Country> get serializer => _$countrySerializer;
}


abstract class CountriesWrapper implements Built<CountriesWrapper, CountriesWrapperBuilder> {
  CountriesWrapper._();

  factory CountriesWrapper([updates(CountriesWrapperBuilder b)]) = _$CountriesWrapper;

  @BuiltValueField(wireName: 'countries')
  BuiltList<Country> get countries;

  String toJson() {
    return json.encode(serializers.serializeWith(CountriesWrapper.serializer, this));
  }

  static CountriesWrapper fromJson(String jsonString) {
    return serializers.deserializeWith(
        CountriesWrapper.serializer, json.decode(jsonString));
  }

  static Serializer<CountriesWrapper> get serializer => _$countriesWrapperSerializer;
}
