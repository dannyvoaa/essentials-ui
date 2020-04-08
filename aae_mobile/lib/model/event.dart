library event;

import 'dart:convert';

import 'package:aae/model/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'event.g.dart';

abstract class Event implements Built<Event, EventBuilder> {
  Event._();

  factory Event([updates(EventBuilder b)]) = _$Event;

  @BuiltValueField(wireName: '_id')
  String get id;

  @BuiltValueField(wireName: 'category')
  String get category;

  @BuiltValueField(wireName: 'author')
  String get author;

  @BuiltValueField(wireName: 'created')
  @nullable
  int get createDate;

  @BuiltValueField(wireName: 'updated')
  @nullable
  int get updateDate;

  @BuiltValueField(wireName: 'eventName')
  String get title;

  @BuiltValueField(wireName: 'eventDescription')
  @nullable
  String get description;

  @BuiltValueField(wireName: 'locationVenue')
  @nullable
  String get venue;

  @BuiltValueField(wireName: 'locationRoomNumber')
  @nullable
  String get roomNumber;

  @BuiltValueField(wireName: 'locationAddress1')
  String get address1;

  @BuiltValueField(wireName: 'locationAddress2')
  @nullable
  String get address2;

  @BuiltValueField(wireName: 'locationCity')
  String get city;

  @BuiltValueField(wireName: 'locationState')
  String get state;

  @BuiltValueField(wireName: 'allDay')
  bool get isAllDay;

  @BuiltValueField(wireName: 'ebrg')
  bool get isEBRG;

  @BuiltValueField(wireName: 'contactName')
  String get contactName;

  @BuiltValueField(wireName: 'contactEmail')
  @nullable
  String get contactEmail;

  @BuiltValueField(wireName: 'contactPhone')
  @nullable
  String get contactPhone;

  @BuiltValueField(wireName: 'start')
  int get startDate;

  @BuiltValueField(wireName: 'end')
  int get endDate;

  @BuiltValueField(wireName: 'timeZoneOffset')
  int get timeZone;

  String toJson() {
    return json.encode(serializers.serializeWith(Event.serializer, this));
  }

  static Event fromJson(String jsonString) {
    return serializers.deserializeWith(
        Event.serializer, json.decode(jsonString));
  }

  static Serializer<Event> get serializer => _$eventSerializer;
}
