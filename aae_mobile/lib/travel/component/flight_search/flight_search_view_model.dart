import 'package:aae/model/flight_search.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'flight_search_view_model.g.dart';

/// View model representing a [FlightSearchView]
abstract class FlightSearchViewModel
    implements Built<FlightSearchViewModel, FlightSearchViewModelBuilder> {
  @nullable
  FlightSearch get flightSearch;

  void Function(String searchField1, String searchField2, String searchDate)
      get loadFlightSearch;

  FlightSearchViewModel._();

  factory FlightSearchViewModel({
    @required FlightSearch flightSearch,
    @required
        Function(String searchField1, String searchField2, String searchDate)
            loadFlightSearch,
  }) = _$FlightSearchViewModel._;
}
