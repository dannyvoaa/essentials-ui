import 'package:aae/model/pnr.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [ReservationDetailComponent].
///
/// Exposes a [ReservationDetailViewModel] for that component to use.

class ReservationDetailBloc {
  static final _log = Logger('ResDetailBloc');
  final TravelRepository _travelRepository;

  Source<TripsViewModel> get viewModel =>
      toSource(combineLatest(_travelRepository.pnrs, _createViewModel));

  @provide
  ReservationDetailBloc(this._travelRepository);

  void loadReservationDetail(String origin, int flightNum, DateTime date) {
    _travelRepository.loadReservationDetail(origin, flightNum, date);
  }

  TripsViewModel _createViewModel(BuiltList<Pnr> pnrs) {
    pnrs = _sortByFirstDepartureDate(pnrs);
    return TripsViewModel((b) => b..pnrs.addAll(pnrs));
  }

//  BuiltList<Pnr> _sortByFirstDepartureDate(BuiltList<Pnr> pnrs) {
//    List<Pnr> pnrsList = pnrs.toList();
//    pnrsList.sort((a, b) => a.firstDepartureDateTime.compareTo(b.firstDepartureDateTime));
//    pnrs = pnrsList.toBuiltList();
//    return pnrs;
//  }
}

/// Constructs new instances of [ReservationDetailBloc]s via the DI framework.
abstract class ResDetailBlocFactory implements ProvidedService {
  @provide
  ReservationDetailBloc resDetailBloc();
}



//class PriorityListBloc {
//  static final _log = Logger('PriorityListBloc');
//  final TravelRepository _travelRepository;
//
//  Observable<PriorityList> _dummyPriorityListObservable;
//
//  Source<PriorityListViewModel> get viewModel =>
//      toSource(combineLatest(_travelRepository.currentPriorityList, _createViewModel));
//
//  @provide
//  PriorityListBloc(this._travelRepository);
//
//  void loadPriorityList(String origin, int flightNum, DateTime date) {
//    _travelRepository.loadPriorityList(origin, flightNum, date);
//  }
//
//  PriorityListViewModel _createViewModel(PriorityList priorityList) {
//    return PriorityListViewModel(
//        priorityList: priorityList,
//        loadPriorityList: loadPriorityList
//    );
//  }
//}
//
///// Constructs new instances of [PriorityListBloc]s via the DI framework.
//abstract class PriorityListBlocFactory implements ProvidedService {
//  @provide
//  PriorityListBloc priorityListBloc();
//}