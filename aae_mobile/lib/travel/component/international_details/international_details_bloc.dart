import 'package:aae/model/reservation_detail.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

import 'components/international_details_action_bar.dart';
import 'components/residency_card.dart';
import 'international_details_view_model.dart';

/// BloC for the [CheckinIntlDetailsComponent].
///
/// Exposes a [InternationalDetailsViewModel] for that component to use.
class InternationalDetailsBloc {
  static final _log = Logger('InternationalDetailsBloc');
  final TravelRepository _travelRepository;

  ReservationDetail _reservationDetails;
  var _passengersStream = createBehaviorSubject<ReservationDetailPassenger>(
    initial: null,
  );

  /// Within the [reservationDetails], the index of the traveler currently being
  /// viewed / edited.
  int _currentTravelerIndex = 0;

  /// Indicates whether the screen is currently editable or not.
  InternationalDetailsEditMode _mode = InternationalDetailsEditMode.readOnly;

  /// If the traveler is not a US citizen this indicates whether they have provided
  /// US Residency Card information or Visa Information.
  DocumentationType _chosenDocumentationType;

  Source<InternationalDetailsViewModel> get viewModel {
    return toSource(combineLatest(_passengersStream, _createViewModel));
  }

  @provide
  InternationalDetailsBloc(this._travelRepository) {
    _travelRepository.reservationDetail.subscribe(
      onNext: _onNewReservation,
    );
  }

  /// Will trigger reservation retrieval if the given PNR is not already loaded.
  void loadPassengerDetails(String pnr, int travelerIndex) {
    _log.info("initializing load: $pnr, $travelerIndex");
    _currentTravelerIndex = travelerIndex ?? 0;
    _travelRepository.loadReservationDetail(pnr, false);
    _travelRepository.loadCountries();

    if (_reservationDetails != null) {
      _passengersStream.sendNext(_reservationDetails.passengers[_currentTravelerIndex]);
    }
  }

  /// Called when a new reservation has been delivered by the Travel Repository.
  _onNewReservation(ReservationDetail reservation) {
    _log.info("received reservation details. pnr: ${reservation?.recordLocator} travelerIndex: $_currentTravelerIndex");
    if (reservation == null || reservation.passengers == null ||
        _currentTravelerIndex >= reservation.passengers.length) {

      _reservationDetails = null;
      _passengersStream.sendNext(null);
      return;
    }

    _reservationDetails = reservation;
    _passengersStream.sendNext(reservation.passengers[_currentTravelerIndex]);
  }

  /// Locally updates the current reservation in preparation for a future check in request.
  /// Note that this does *not* update the PNR in Sabre or the PNR Summary in ATD. The user
  /// must complete the check-in flow for any changes to be applied.
  void _updatePassenger(ReservationDetailPassengerBuilder passengerBuilder) {
    ReservationDetailBuilder reservation = _reservationDetails.toBuilder();
    reservation.passengers[_currentTravelerIndex] = passengerBuilder.build();

    _travelRepository.updateReservationDetail(reservation.build());
  }

  InternationalDetailsViewModel _createViewModel(ReservationDetailPassenger passenger) {
    return InternationalDetailsViewModel(
      passenger: passenger,
      countries: _travelRepository.cachedCountries,
      recordLocator: _reservationDetails?.recordLocator,
      currentTravelerIndex: _currentTravelerIndex,
      hasMoreTravelers: _reservationDetails == null ? false : _currentTravelerIndex < _reservationDetails.passengers.length - 1,
      mode: this._mode,
      chosenDocumentationType: this._chosenDocumentationType,
      updatePassenger: this._updatePassenger,
    );
  }
}

/// Constructs new instances of [InternationalDetailsBloc]s via the DI framework.
abstract class InternationalDetailsBlocFactory implements ProvidedService {
  @provide
  InternationalDetailsBloc checkinIntlDetailsBloc();
}