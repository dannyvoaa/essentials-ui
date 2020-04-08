import 'package:built_value/built_value.dart';

part 'points_balance_view_model.g.dart';

/// View model representing a [PointsBalanceView]
abstract class PointsBalanceViewModel
    implements Built<PointsBalanceViewModel, PointsBalanceViewModelBuilder> {
  String get currentBalance;

  PointsBalanceViewModel._();

  factory PointsBalanceViewModel([updates(PointsBalanceViewModelBuilder b)]) =
      _$PointsBalanceViewModel;
}
