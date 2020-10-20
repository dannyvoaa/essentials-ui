library search_state;

import 'dart:convert';

import 'package:aae/model/flight_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_state.g.dart';

abstract class SearchState implements Built<SearchState, SearchStateBuilder> {
  bool get isLoading;
  FlightStatus get searchResults;
  String get error;
  SearchState._();

  bool get isInitial =>
      !isLoading && searchResults.flightNumber.isEmpty && error == '';

  bool get isSuccessful =>
      !isLoading && searchResults.flightNumber.isNotEmpty && error == '';

  factory SearchState([updates(SearchStateBuilder b)]) = _$SearchState;

  factory SearchState.initial() {
    return SearchState((b) => b
      ..isLoading = false
      ..searchResults.replace(FlightStatus())
      ..error = '');
  }

  factory SearchState.loading() {
    return SearchState((b) => b
      ..isLoading = true
      ..searchResults.replace(FlightStatus())
      ..error = '');
  }

  factory SearchState.failure() {
    return SearchState((b) => b
      ..isLoading = false
      ..searchResults.replace(FlightStatus())
      ..error = error);
  }

  factory SearchState.success() {
    return SearchState((b) => b
      ..isLoading = false
      ..searchResults.replace(FlightStatus())
      ..error = '');
  }
}
