import 'package:aae/model/boarding_pass.dart';
import 'package:aae/model/boarding_pass_wrapper.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_component.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'boarding_pass_view_model.g.dart';


/// View model representing a [BoardingPassView]
abstract class BoardingPassViewModel
    implements Built<BoardingPassViewModel, BoardingPassViewModelBuilder> {

  @nullable
  BuiltList<BoardingPass> get boardingPasses;

  @nullable
  ReservationDetail get reservationDetail;

  @nullable
  Function({String pnr, bool forceRefresh}) get loadBoardingPasses;

  BoardingPassViewModel._();

  factory BoardingPassViewModel({
    @required BuiltList<BoardingPass> boardingPasses,
    @required ReservationDetail reservationDetail,
    @required Function({String pnr, bool forceRefresh}) loadBoardingPasses,
  }) = _$BoardingPassViewModel._;
}