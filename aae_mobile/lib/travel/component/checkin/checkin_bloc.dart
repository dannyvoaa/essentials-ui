import 'package:aae/model/reservation_detail.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/travel/component/checkin/checkin_component.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [CheckInComponent].
///
/// Exposes a [CheckInViewModel] for that component to use.


class CheckInBloc {
  static final _log = Logger('CheckInBloc');
  final TravelRepository _travelRepository;
  String pnr;
  Set<int> travelerIdsForCheckIn = {};
  ReservationDetail reservation;

  Observable<ReservationDetail> _dummyPriorityListObservable;

  Source<CheckInViewModel> get viewModel =>
      toSource(combineLatest(_travelRepository.reservationDetail, _createViewModel));

  @provide
  CheckInBloc(this._travelRepository){
    _travelRepository.reservationDetail.subscribe(
        onNext: onNewReservationData
    );
  }

  void onNewReservationData(ReservationDetail reservation){
    if (reservation == null) {
      pnr = null;
      this.reservation = null;
      return;
    }

    pnr = reservation.recordLocator;
    this.reservation = reservation;
    travelerIdsForCheckIn.clear();
    for (ReservationDetailPassenger traveler in reservation.passengers){
      travelerIdsForCheckIn.add(traveler.nrsTravelerId);
    }
  }

  void loadReservationDetail(String pnr) {
    _travelRepository.loadReservationDetail(pnr, false);
    _log.info(travelerIdsForCheckIn);
  }

  void performCheckIn(){
    _travelRepository.performCheckIn(CheckInArguments(
      pnr: pnr,
      passengers: _buildSelectedPassengersList(),
    ));
  }

  BuiltList<ReservationDetailPassenger> _buildSelectedPassengersList() {
    if (reservation == null || reservation.passengers == null || travelerIdsForCheckIn == null)
      return null;

    ListBuilder<ReservationDetailPassenger> passengers = ListBuilder<ReservationDetailPassenger>();
    for(ReservationDetailPassenger currPassenger in reservation.passengers) {
      if (travelerIdsForCheckIn.contains(currPassenger.nrsTravelerId)) {
        passengers.add(currPassenger);
      }
    }

    return passengers.build();
  }

  void setTravelerForCheckIn(int travelerId){
    travelerIdsForCheckIn.add(travelerId);
    _log.info(travelerIdsForCheckIn);
  }

  void removeTravelerForCheckIn(int travelerId){
    travelerIdsForCheckIn.remove(travelerId);
    _log.info(travelerIdsForCheckIn);
  }

  CheckInViewModel _createViewModel(ReservationDetail reservationDetail) {
    return CheckInViewModel(
        reservationDetail: reservationDetail,
        loadReservationDetail: loadReservationDetail,
        performCheckIn: performCheckIn,
        setTravelerForCheckIn: setTravelerForCheckIn,
        removeTravelerForCheckIn: removeTravelerForCheckIn,
    );
  }
}

/// Constructs new instances of [CheckInBloc]s via the DI framework.
abstract class CheckInBlocFactory implements ProvidedService {
  @provide
  CheckInBloc checkInBloc();
}