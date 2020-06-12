import 'package:aae/model/pnr_info.dart';
import 'package:aae/model/recognition_register.dart';
import 'package:aae/model/trips.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'trips_view_model.g.dart';

/// View model representing a [TripsView]
abstract class TripsViewModel
    implements Built<TripsViewModel, TripsViewModelBuilder> {
  BuiltList<PnrInfo> get trips;

  TripsViewModel._();

  factory TripsViewModel([updates(TripsViewModelBuilder b)]) =
      _$TripsViewModel;
}
