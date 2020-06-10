import 'package:built_value/built_value.dart';

part 'current_trips_view_model.g.dart';

/// View model representing a [CurrentTripsView]
abstract class CurrentTripsViewModel
    implements Built<CurrentTripsViewModel, CurrentTripsViewModelBuilder> {
  String get currentBalance;

  CurrentTripsViewModel._();

  factory CurrentTripsViewModel([updates(CurrentTripsViewModelBuilder b)]) =
      _$CurrentTripsViewModel;
}
