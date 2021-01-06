import 'package:aae/model/airport.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'airport_picker_view_model.g.dart';

/// View model representing the business logic of a [AirportPickerView].
abstract class AirportPickerViewModel
    implements Built<AirportPickerViewModel, AirportPickerViewModelBuilder> {

  /// The airports to be displayed, potentially filtered by a search term
  /// provided by the [updateAirportFilter] function.
  @nullable List<Airport> get filteredAirports;

  /// The indexes in the [filteredAirports] list at which the first appearance
  /// of an airport beginning with each letter exists. For example, if ABQ is
  /// third in the list 'A' will map to 2.
  ///
  /// Returns null if no matching airport exists.
  @nullable Map<String, int> get charIndexes;

  /// A function that can be used to update the [filteredAirports] list to
  /// include only airports that match the given filter [String].
  void Function(String) get updateAirportFilter;

  AirportPickerViewModel._();

  factory AirportPickerViewModel({
    @required List<Airport> filteredAirports,
    @required Map<String, int> charIndexes,
    @required Function(String) updateAirportFilter,
  }) = _$AirportPickerViewModel._;
}


