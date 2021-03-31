library reservation_detail_passenger;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reservation_detail_passenger.g.dart';

abstract class ReservationDetailPassenger implements Built<ReservationDetailPassenger, ReservationDetailPassengerBuilder> {
  ReservationDetailPassenger._();

  factory ReservationDetailPassenger([updates(ReservationDetailPassengerBuilder b)]) =
  _$ReservationDetailPassenger;

  @BuiltValueField(wireName: 'firstName')
  @nullable
  String get firstName;

  @BuiltValueField(wireName: 'lastName')
  @nullable
  String get lastName;

  @BuiltValueField(wireName: 'nrsTravelerId')
  @nullable
  int get nrsTravelerId;

  @BuiltValueField(wireName: 'passengerId')
  @nullable
  String get passengerId;

  @BuiltValueField(wireName: 'countryOfResidence')
  @nullable
  String get countryOfResidence;

  @BuiltValueField(wireName: 'countryOfCitizenship')
  @nullable
  String get countryOfCitizenship;

  @BuiltValueField(wireName: 'passport')
  @nullable
  Passport get passport;

  @BuiltValueField(wireName: 'visa')
  @nullable
  Visa get visa;

  @BuiltValueField(wireName: 'usResidencyCard')
  @nullable
  UsResidencyCard get usResidencyCard;

  @BuiltValueField(wireName: 'emergencyContact')
  @nullable
  EmergencyContact get emergencyContact;

  @BuiltValueField(wireName: 'destination')
  @nullable
  Destination get destination;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ReservationDetailPassenger.serializer, this));
  }

  static ReservationDetailPassenger fromJson(String jsonString) {
    return serializers.deserializeWith(
        ReservationDetailPassenger.serializer, json.decode(jsonString));
  }

  static Serializer<ReservationDetailPassenger> get serializer =>
      _$reservationDetailPassengerSerializer;

}


abstract class Passport implements Built<Passport, PassportBuilder> {
  Passport._();

  factory Passport([updates(PassportBuilder b)]) = _$Passport;

  @BuiltValueField(wireName: 'number')
  @nullable
  String get number;

  @BuiltValueField(wireName: 'expirationDate')
  @nullable
  String get expirationDate;

  @BuiltValueField(wireName: 'issuingCountry')
  @nullable
  String get issuingCountry;

  String toJson() {
    return json.encode(serializers.serializeWith(Passport.serializer, this));
  }

  static Passport fromJson(String jsonString) {
    return serializers.deserializeWith(
        Passport.serializer, json.decode(jsonString));
  }

  static Serializer<Passport> get serializer => _$passportSerializer;
}


abstract class Visa implements Built<Visa, VisaBuilder> {
  Visa._();

  factory Visa([updates(VisaBuilder b)]) = _$Visa;

  @BuiltValueField(wireName: 'number')
  @nullable
  String get number;

  @BuiltValueField(wireName: 'issuedDate')
  @nullable
  String get issuedDate;

  @BuiltValueField(wireName: 'expirationDate')
  @nullable
  String get expirationDate;

  @BuiltValueField(wireName: 'issuingCity')
  @nullable
  String get issuingCity;

  String toJson() {
    return json.encode(serializers.serializeWith(Visa.serializer, this));
  }

  static Visa fromJson(String jsonString) {
    return serializers.deserializeWith(
        Visa.serializer, json.decode(jsonString));
  }

  static Serializer<Visa> get serializer => _$visaSerializer;
}


abstract class UsResidencyCard implements Built<UsResidencyCard, UsResidencyCardBuilder> {
  UsResidencyCard._();

  factory UsResidencyCard([updates(UsResidencyCardBuilder b)]) = _$UsResidencyCard;

  @BuiltValueField(wireName: 'number')
  @nullable
  String get number;

  @BuiltValueField(wireName: 'expirationDate')
  @nullable
  String get expirationDate;

  String toJson() {
    return json.encode(serializers.serializeWith(UsResidencyCard.serializer, this));
  }

  static UsResidencyCard fromJson(String jsonString) {
    return serializers.deserializeWith(
        UsResidencyCard.serializer, json.decode(jsonString));
  }

  static Serializer<UsResidencyCard> get serializer => _$usResidencyCardSerializer;
}


abstract class EmergencyContact implements Built<EmergencyContact, EmergencyContactBuilder> {
  EmergencyContact._();

  factory EmergencyContact([updates(EmergencyContactBuilder b)]) = _$EmergencyContact;

  @BuiltValueField(wireName: 'firstName')
  @nullable
  String get firstName;

  @BuiltValueField(wireName: 'lastName')
  @nullable
  String get lastName;

  @BuiltValueField(wireName: 'country')
  @nullable
  String get country;

  @BuiltValueField(wireName: 'phoneNumber')
  @nullable
  String get phoneNumber;

  String toJson() {
    return json.encode(serializers.serializeWith(EmergencyContact.serializer, this));
  }

  static EmergencyContact fromJson(String jsonString) {
    return serializers.deserializeWith(
        EmergencyContact.serializer, json.decode(jsonString));
  }

  static Serializer<EmergencyContact> get serializer => _$emergencyContactSerializer;
}


abstract class Destination implements Built<Destination, DestinationBuilder> {
  Destination._();

  factory Destination([updates(DestinationBuilder b)]) = _$Destination;

  @BuiltValueField(wireName: 'address')
  @nullable
  String get address;

  @BuiltValueField(wireName: 'city')
  @nullable
  String get city;

  @BuiltValueField(wireName: 'state')
  @nullable
  String get state;

  @BuiltValueField(wireName: 'zipCode')
  @nullable
  String get zipCode;

  String toJson() {
    return json.encode(serializers.serializeWith(Destination.serializer, this));
  }

  static Destination fromJson(String jsonString) {
    return serializers.deserializeWith(
        Destination.serializer, json.decode(jsonString));
  }

  static Serializer<Destination> get serializer => _$destinationSerializer;
}