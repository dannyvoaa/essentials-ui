import 'package:aae/model/flight_search.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

import '../../../provided_service.dart';
import 'flight_search_view_model.dart';

/// BloC for the [FlightSearchComponent].
///
/// Exposes a [FlightSearchViewModel] for that component to use.

class FlightSearchBloc {
  static final _log = Logger('FlightSearchBloc');
  final TravelRepository _travelRepository;

  loadFlightSearch(
      String searchField1, String searchField2, String searchDate) async {
    _travelRepository.loadFlightSearch(searchField1, searchField2, searchDate);
  }

  Source<FlightSearchViewModel> get viewModel =>
      toSource(combineLatest(_travelRepository.flightSearch, _createViewModel));

  @provide
  FlightSearchBloc(this._travelRepository);

  FlightSearchViewModel _createViewModel(FlightSearch flightSearch) {
    return FlightSearchViewModel(
        flightSearch: flightSearch,
        loadFlightSearch: loadFlightSearch);
  }
}

/// Constructs new instances of [FlightSearchBloc]s via the DI framework.
abstract class FlightSearchBlocFactory implements ProvidedService {
  @provide
  FlightSearchBloc flightSearchBloc();
}
