import 'package:aae/model/pnr.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'res_detail_view_model.g.dart';

/// View model representing a [ReservationDetailView]
abstract class ReservationDetailViewModel
    implements Built<ReservationDetailViewModel, ReservationDetailViewModelBuilder> {
  BuiltList<Pnr> get pnrs;

  ReservationDetailViewModel._();

  factory ReservationDetailViewModel([updates(ReservationDetailViewModelBuilder b)]) = _$ReservationDetailViewModel;
}