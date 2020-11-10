import 'package:aae/model/flight_status.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'flight_status_view_model.g.dart';

/// View model representing a [FlightStatusView]
abstract class FlightStatusViewModel
    implements Built<FlightStatusViewModel, FlightStatusViewModelBuilder> {
  @nullable
  FlightStatus get flightStatus;

  void Function(String searchField1, String searchField2, String searchDate)
      get loadFlightStatus;

  FlightStatusViewModel._();

  factory FlightStatusViewModel({
    @required FlightStatus flightStatus,
    @required
        Function(String searchField1, String searchField2, String searchDate)
            loadFlightStatus,
  }) = _$FlightStatusViewModel._;
}
