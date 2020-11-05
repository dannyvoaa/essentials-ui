import 'package:aae/model/pnr.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'res_detail_view_model.g.dart';

/// View model representing a [ReservationDetailView]
abstract class ReservationDetailViewModel
    implements Built<ReservationDetailViewModel, ReservationDetailViewModelBuilder> {
  BuiltList<Pnr> get pnr;

//  ReservationDetailViewModel._();
//
//  factory ReservationDetailViewModel([updates(ReservationDetailViewModelBuilder b)]) = _$ReservationDetailViewModel;

  @nullable
  ReservationDetail get reservationDetail;

  void Function(String pnr) get loadReservationDetail;

  ReservationDetailViewModel._();

  factory ReservationDetailViewModel({
    @required ReservationDetail reservationDetail,
    @required Function(String pnr) loadReservationDetail,
  }) = _$ReservationDetailViewModel._;

}





//import 'package:aae/model/priority_list.dart';
//import 'package:built_value/built_value.dart';
//import 'package:flutter/material.dart' hide Builder;
//
//part 'priority_list_view_model.g.dart';
//
///// View model representing a [PriorityListView]
//abstract class PriorityListViewModel
//    implements Built<PriorityListViewModel, PriorityListViewModelBuilder> {
//
//  @nullable
//  PriorityList get priorityList;
//
//  void Function(String origin, int flightNum, DateTime date) get loadPriorityList;
//
//  PriorityListViewModel._();
//
//  factory PriorityListViewModel({
//    @required PriorityList priorityList,
//    @required Function(String origin, int flightNum, DateTime date) loadPriorityList,
//  }) = _$PriorityListViewModel._;
//}