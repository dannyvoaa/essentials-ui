import 'package:aae/model/recognition_register.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'points_history_view_model.g.dart';

/// View model representing a [PointsHistoryView]
abstract class PointsHistoryViewModel
    implements Built<PointsHistoryViewModel, PointsHistoryViewModelBuilder> {
  BuiltList<RecognitionRegister> get recognitionHistory;

  PointsHistoryViewModel._();

  factory PointsHistoryViewModel([updates(PointsHistoryViewModelBuilder b)]) =
      _$PointsHistoryViewModel;
}
