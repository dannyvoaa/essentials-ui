import 'package:aae/model/flight_status.dart';
import 'package:aae/model/pnr.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'flight_status_view_model.g.dart';

/// View model representing a [FlightStatusView]
abstract class FlightStatusViewModel
    implements Built<FlightStatusViewModel, FlightStatusViewModelBuilder> {
  FlightStatus get flightStatus;

  FlightStatusViewModel._();

  factory FlightStatusViewModel([updates(FlightStatusViewModelBuilder b)]) = _$FlightStatusViewModel;
}
