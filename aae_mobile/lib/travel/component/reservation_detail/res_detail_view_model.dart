import 'package:aae/model/airport.dart';
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

  @nullable
  BuiltList<Airport> get airports;

  void Function(String pnr) get loadReservationDetail;

  String getAirportName (String airportCode) {
    if(airportCode == null){return null;}
    if(airports == null){return null;}
    for (Airport currentAirport in airports) {
      if (currentAirport.code == airportCode){
        
        return currentAirport.displayName;
      }
    }
    return null;
  }

  ReservationDetailViewModel._();

  factory ReservationDetailViewModel({
    @required ReservationDetail reservationDetail,
    @required BuiltList<Airport> airports,
    @required Function(String pnr) loadReservationDetail,
  }) = _$ReservationDetailViewModel._;
}