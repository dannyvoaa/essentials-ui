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
  bool searchPending = false;
  var _searchResults =
      createBehaviorSubject<FlightSearch>(initial: FlightSearch());

  loadFlightSearch(
      String searchField1, String searchField2, String searchDate) async {
    searchPending = true;
    _travelRepository.loadFlightSearch(searchField1, searchField2, searchDate);
  }

  Source<FlightSearchViewModel> get viewModel =>
      toSource(combineLatest(_searchResults, _createViewModel));

  _populateFlightSearch(flightSearch) {
    if (!searchPending) return;
    if (flightSearch != null) {
      _searchResults.sendNext(flightSearch);
      searchPending = false;
    } else {
      _searchResults.sendNext(null);
    }
  }

  @provide
  FlightSearchBloc(this._travelRepository) {
    _travelRepository.flightSearch.subscribe(onNext: _populateFlightSearch);
  }

  FlightSearchViewModel _createViewModel(FlightSearch flightSearch) {
    return FlightSearchViewModel(
        flightSearch: flightSearch, loadFlightSearch: loadFlightSearch);
  }
}

/// Constructs new instances of [FlightSearchBloc]s via the DI framework.
abstract class FlightSearchBlocFactory implements ProvidedService {
  @provide
  FlightSearchBloc flightSearchBloc();
}
