import 'package:aae/model/boarding_pass_wrapper.dart';
import 'package:aae/model/boarding_pass.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_view_model.dart';
import 'package:aae/travel/component/reservation_detail/res_detail_view_model.dart';
import 'package:aae/travel/component/checkin/checkin_component.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [BoardingPassComponent].
///
/// Exposes a [BoardingPassViewModel] for that component to use.

class BoardingPassBloc {
  static final _log = Logger('BoardingPassBloc');
  final TravelRepository _travelRepository;
  String pnr;
  bool forceRefresh;
  CheckInArguments checkInArgs;

  Observable<BoardingPass> _dummyBoardingPassObservable;
  Observable<ReservationDetail> _dummyReservationDetailObservable;

  Source<BoardingPassViewModel> get viewModel => toSource(combineLatest2(
      _travelRepository.boardingPasses,
      _travelRepository.reservationDetail,
      _createViewModel));

  @provide
  BoardingPassBloc(this._travelRepository);

  void loadBoardingPasses({String pnr, bool forceRefresh}) {
    _travelRepository.loadBoardingPasses(pnr, forceRefresh);
  }

//  void loadReservationDetail(String pnr) {
//    _travelRepository.loadReservationDetail(pnr);
//  }

  BoardingPassViewModel _createViewModel(
    BuiltList<BoardingPass> boardingPasses,
    ReservationDetail reservationDetail,
  ) {
    return BoardingPassViewModel(
      boardingPasses: boardingPasses,
      reservationDetail: reservationDetail,
      loadBoardingPasses: loadBoardingPasses,
    );
  }
}

/// Constructs new instances of [BoardingPassBloc]s via the DI framework.
abstract class BoardingPassBlocFactory implements ProvidedService {
  @provide
  BoardingPassBloc boardingPassBloc();
}
