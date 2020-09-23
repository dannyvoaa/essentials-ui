import 'package:aae/model/pnr.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/travel/component/flight_status/flight_status_view_model.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [TripsComponent].
///
/// Exposes a [FlightStatusViewModel] for that component to use.

class FlightStatusBloc {
  static final _log = Logger('FlightStatusBloc');
  final TravelRepository _travelRepository;

  Source<FlightStatusViewModel> get viewModel =>
      toSource(combineLatest(_travelRepository.pnrs, _createViewModel));

  @provide
  FlightStatusBloc(this._travelRepository);

  FlightStatusViewModel _createViewModel(BuiltList<Pnr> pnrs) {
    pnrs = _sortByFirstDepartureDate(pnrs);
    return FlightStatusViewModel((b) => b..pnrs.addAll(pnrs));
  }

  BuiltList<Pnr> _sortByFirstDepartureDate(BuiltList<Pnr> pnrs) {
    List<Pnr> pnrsList = pnrs.toList();
    pnrsList.sort((a, b) => a.firstDepartureDateTime.compareTo(b.firstDepartureDateTime));
    pnrs = pnrsList.toBuiltList();
    return pnrs;
  }
}

/// Constructs new instances of [FlightStatusBloc]s via the DI framework.
abstract class FlightStatusBlocFactory implements ProvidedService {
  @provide
  FlightStatusBloc flightStatusBloc();
}
