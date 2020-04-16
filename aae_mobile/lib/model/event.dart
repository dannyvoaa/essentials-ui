library event;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'event.g.dart';

abstract class Event implements Built<Event, EventBuilder> {
  Event._();

  factory Event([updates(EventBuilder b)]) = _$Event;

  @BuiltValueField(wireName: '_id')
  String get id;

  @nullable
  String get rev;

  bool get allDay;

  String get contactEmail;

  String get contactName;

  String get contactPhone;

  bool get ebrg;

  int get end;

  @nullable
  int get endLocal;

  int get endYear;

  int get endMonth;

  int get endDay;

  int get endHour;

  int get endMinute;

  String get eventDescription;

  String get eventName;

  String get locationAddress1;

  String get locationAddress2;

  String get locationCity;

  String get locationState;

  String get locationRoomNumber;

  String get locationVenue;

  int get start;

  @nullable
  int get startLocal;

  int get startYear;

  int get startMonth;

  int get startDay;

  int get startHour;

  int get startMinute;

  int get timeZoneOffset;

  int get created;

  String get createdBy;

  int get updated;

  @nullable
  String get updatedBy;

  String toJson() {
    return json.encode(serializers.serializeWith(Event.serializer, this));
  }

  static Event fromJson(String jsonString) {
    return serializers.deserializeWith(
        Event.serializer, json.decode(jsonString));
  }

  static Serializer<Event> get serializer => _$eventSerializer;
}
