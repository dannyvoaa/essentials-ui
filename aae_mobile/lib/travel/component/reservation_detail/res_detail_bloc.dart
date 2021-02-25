import 'package:aae/model/airport.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [ReservationDetailComponent].
///
/// Exposes a [ReservationDetailViewModel] for that component to use.


class ReservationDetailBloc {
  static final _log = Logger('PriorityListBloc');
  final TravelRepository _travelRepository;

  Observable<ReservationDetail> _dummyPriorityListObservable;

  Source<ReservationDetailViewModel> get viewModel =>
      toSource(combineLatest2(_travelRepository.reservationDetail, _travelRepository.airports, _createViewModel));

  @provide
  ReservationDetailBloc(this._travelRepository);

  void loadReservationDetail(String pnr) {
    _travelRepository.loadReservationDetail(pnr);
  }

  ReservationDetailViewModel _createViewModel(ReservationDetail reservationDetail, BuiltList<Airport> airports) {
    return ReservationDetailViewModel(
        reservationDetail: reservationDetail,
        airports: airports,
        loadReservationDetail: loadReservationDetail
    );
  }
}

/// Constructs new instances of [PriorityListBloc]s via the DI framework.
abstract class ReservationDetailBlocFactory implements ProvidedService {
  @provide
  ReservationDetailBloc reservationDetailBloc();
}