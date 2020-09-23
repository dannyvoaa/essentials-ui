import 'package:aae/model/pnr.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'flight_status_view_model.g.dart';

/// View model representing a [FlightStatusView]
abstract class FlightStatusViewModel
    implements Built<FlightStatusViewModel, FlightStatusViewModelBuilder> {
  BuiltList<Pnr> get pnrs;

  FlightStatusViewModel._();

  factory FlightStatusViewModel([updates(FlightStatusViewModelBuilder b)]) = _$FlightStatusViewModel;
}
