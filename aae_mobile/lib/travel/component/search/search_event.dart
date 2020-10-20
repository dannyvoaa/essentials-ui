library search_event;

import 'dart:convert';

import 'package:aae/model/flight_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_event.g.dart';

enum EventType {search}
class SearchEvent {
  FlightStatus flightStatus;
  EventType eventType;
}


abstract class SearchInitiated extends SearchEvent
    implements Built<SearchInitiated, SearchInitiatedBuilder> {
  String get query;

  SearchInitiated._();

  factory SearchInitiated([updates(SearchInitiatedBuilder b)]) =
      _$SearchInitiated;
}
