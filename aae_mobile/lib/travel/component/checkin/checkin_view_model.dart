import 'package:aae/model/reservation_detail.dart';
import 'package:aae/travel/component/checkin/checkin_component.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'checkin_view_model.g.dart';


/// View model representing a [CheckInView]
abstract class CheckInViewModel
    implements Built<CheckInViewModel, CheckInViewModelBuilder> {

  @nullable
  ReservationDetail get reservationDetail;

  @nullable
  void Function(String pnr) get loadReservationDetail;

  @nullable
  void Function(int travelerId) get setTravelerForCheckIn;

  @nullable
  void Function(int travelerId) get removeTravelerForCheckIn;

  @nullable
  void Function() get performCheckIn;

  @nullable
  void Function() get cancelReservation;

  CheckInViewModel._();

  factory CheckInViewModel({
    @required ReservationDetail reservationDetail,
    @required Function(String pnr) loadReservationDetail,
    @required Function() performCheckIn,
    @required Function() cancelReservation,
    @required Function(int travelerId) setTravelerForCheckIn,
    @required Function(int travelerId) removeTravelerForCheckIn,
  }) = _$CheckInViewModel._;
}