//import 'package:aae/model/pnr.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'res_detail_view_model.g.dart';


/// View model representing a [ReservationDetailView]
abstract class ReservationDetailViewModel
    implements Built<ReservationDetailViewModel, ReservationDetailViewModelBuilder> {

  @nullable
  ReservationDetail get reservationDetail;

  void Function(String pnr) get loadReservationDetail;

  ReservationDetailViewModel._();

  factory ReservationDetailViewModel({
    @required ReservationDetail reservationDetail,
    @required Function(String pnr) loadReservationDetail,
  }) = _$ReservationDetailViewModel._;
}