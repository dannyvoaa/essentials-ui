import 'package:aae/model/airport.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

import 'airport_picker_view_model.dart';

/// BloC for the [AirportPickerComponent].
///
/// Exposes a [AirportPickerViewModel] for that component to use.
class AirportPickerBloc {
  static final _log = Logger('AirportPickerBloc');
  final TravelRepository _travelRepository;

  BuiltList<Airport> _allAirports;
  bool _initialized = false;

  var _filteredAirports = createBehaviorSubject<List<Airport>>(
    initial: List<Airport>(),
  );

  var _charIndexes = createBehaviorSubject<Map<String, int>>(
    initial: Map<String, int>(),
  );

  Source<AirportPickerViewModel> get viewModel => toSource(combineLatest2(
      _filteredAirports,
      _charIndexes,
      _createViewModel)
  );

  @provide
  AirportPickerBloc(this._travelRepository) {
    // ask the back end for airport information and subscribe to the pipe that
    // gives us the results.
    _travelRepository.airports.subscribe(
        onNext: _populateAirportList
    );

    _travelRepository.loadAirports();
  }

  /// Given the [filter] String, will filter the list of airports down to
  /// any that match. Will then stream updated data to the UI.
  updateAirportFilter(String filter) {
    _log.info("filtering airport list with '$filter'");

    List<Airport> filteredAirportsList = List();
    _allAirports.forEach((airport) {
      if (filter.matches(airport)) {
        filteredAirportsList.add(airport);
      }
    });

    _filteredAirports.sendNext(filteredAirportsList);
    _charIndexes.sendNext(_calculateCharIndexes(filteredAirportsList));
  }

  /// Builds a map identifying the first index of a an airport for each
  /// character in the alphabet.
  ///
  /// Assumes the list is sorted alphabetically.
  Map<String, int> _calculateCharIndexes(List<Airport> airports) {
    var indexes = Map<String, int>();

    int currIndex = 0;
    String currChar = "";
    for(var currAirport in airports) {
      // don't trip over bad data!
      if (currAirport == null || currAirport.code == null)
        continue;

      // if this is the first time we've seen this new character, make a
      // record of it.
      String newChar = currAirport.code.substring(0, 1);
      if (currChar != newChar) {
        indexes[newChar] = currIndex;
        currChar = newChar;
      }

      currIndex++;
    }

    return indexes;
  }

  /// Constructs the view model for the UI when one of the watched streams
  /// has new data. See the above [viewModel] declaration.
  AirportPickerViewModel _createViewModel(List<Airport> filteredAirports,
                                          Map<String, int> charIndexes) {
    return AirportPickerViewModel(
      filteredAirports: filteredAirports,
      charIndexes: charIndexes,
      updateAirportFilter: updateAirportFilter,
    );
  }

  /// Updates the locally stored airport list when new data arrives from
  /// the back end.
  _populateAirportList(newAirportList) {
    _allAirports = newAirportList;

    if (!_initialized) {
      _log.info("initializing filtered airport list");
      updateAirportFilter(null);
      _initialized = true;
    }
  }
}

/// Constructs new instances of [AirportPickerBloc]s via the DI framework.
abstract class AirportPickerBlocFactory implements ProvidedService {
  @provide
  AirportPickerBloc airportPickerBloc();
}

/// Locally adds a method to the [String] class to determine if an [Airport]
/// has any fields containing the given filter [String].
extension _AirportFilterMatcher on String {

  matches(Airport airport) {
    // if the user has not entered a filter, anything is a match
    if (this == null || this.isEmpty)
      return true;

    // if any of our fields match, we have a winner.
    if (this._matchesStr(airport.code) ||
        this._matchesStr(airport.displayName)) {
      return true;
    }

    // discarded!
    return false;
  }

  _matchesStr(String locationDetails) {
    // If we don't have the given type of information for this airport we can't
    // match on it, so we reject this comparison. For example, an airport in a
    // location that has no state or province designation can't match a filter
    // based on that field.
    if (locationDetails == null || locationDetails.isEmpty)
      return false;

    String upperLocStr = locationDetails.toUpperCase();
    String upperFilter = this.toUpperCase();

    return upperLocStr.contains(upperFilter);
  }
}



