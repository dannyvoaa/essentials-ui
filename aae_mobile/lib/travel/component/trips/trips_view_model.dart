import 'package:aae/model/pnrs.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'trips_view_model.g.dart';

/// View model representing a [TripsView]
abstract class TripsViewModel
    implements Built<TripsViewModel, TripsViewModelBuilder> {
  BuiltList<Pnrs> get trips;

  TripsViewModel._();

  factory TripsViewModel([updates(TripsViewModelBuilder b)]) =
  _$TripsViewModel;
}
